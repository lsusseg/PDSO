import os
import argparse
import jittor as jt
import jittor.nn as nn

jt.flags.use_cuda = 1
import numpy as np
from tqdm import tqdm
import jittor.transform as transforms
from PIL import Image
import src.resnet as resnet_model
from src.singlecropdataset import InferImageFolder
from src.utils import bool_flag


def parse_args():
    parser = argparse.ArgumentParser(description="Inference")
    parser.add_argument("--mode", type=str, required=True)
    parser.add_argument("--dump_path", type=str, default=None, help="The path to save results.")
    parser.add_argument("--data_path", type=str, default=None, help="The path to ImagenetS dataset.")
    parser.add_argument("--pretrained", type=str, default=None, help="The model checkpoint file.")
    parser.add_argument("-a", "--arch", metavar="ARCH", help="The model architecture.")
    parser.add_argument("-c", "--num-classes", default=50, type=int, help="The number of classes.")
    parser.add_argument("-t", "--threshold", default=0, type=float,
                        help="The threshold to filter the 'others' categroies.")
    parser.add_argument("--test", action='store_true',
                        help="whether to save the logit. Enabled when finding the best threshold.")
    parser.add_argument("--centroid", type=str, default=None, help="The centroids of clustering.")
    parser.add_argument("--checkpoint_key", type=str, default='state_dict', help="key of model in checkpoint")

    args = parser.parse_args()

    return args

def load_annotations(ann_file):
    data_infos = {}
    with open(ann_file) as f:
        samples = [x.strip().split(' ') for x in f.readlines()]
        for i,j in samples:
            data_infos[i] = np.array((j), dtype=np.int64)
    return data_infos

def main_worker(args):
    # centroids = np.load(args.centroid)
    # centroids = jt.array(centroids)
    # centroids = jt.normalize(centroids, dim=1, p=2)

    # build model
    if 'resnet' in args.arch:
        model = resnet_model.__dict__[args.arch](hidden_mlp=0, output_dim=0, nmb_prototypes=0, train_mode='pixelattn')
    else:
        raise NotImplementedError()

    checkpoint = jt.load(args.pretrained)[args.checkpoint_key]
    # for k in list(checkpoint.keys()):
    #     if k.startswith('module.'):
    #         checkpoint[k[len('module.'):]] = checkpoint[k]
    #         del checkpoint[k]
    #         k = k[len('module.'):]
    #     if k not in model.state_dict().keys():
    #         del checkpoint[k]
    model.load_state_dict(checkpoint)
    print("=> loaded model '{}'".format(args.pretrained))
    model.eval()

    # build dataset
    data_path = os.path.join(args.data_path, args.mode)
    normalize = transforms.ImageNormalize(
        mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]
    )
    dataset = InferImageFolder(
        root=data_path,
        transform=transforms.Compose(
            [
                transforms.Resize(224),
                transforms.ToTensor(),
                normalize,
            ]
        ),
    )
    dataloader = dataset.set_attrs(
        batch_size=1, num_workers=16, drop_last=False,  shuffle=False
    )

    # dump_path = os.path.join(args.dump_path, args.mode)

    # if not jt.in_mpi or (jt.in_mpi and jt.rank == 0):
    #     for cate in os.listdir(data_path):
    #         if not os.path.exists(os.path.join(dump_path, cate)):
    #             os.makedirs(os.path.join(dump_path, cate))
    labeled = []
    labeled2=[]
    labeled3 = []
    labeled_xy_avg_all=[]
    labeled_xy_avg = []
    lossall=0
    img_label = load_annotations('./weights/pass50/pixel_attention/cluster/train_labeled.txt')
    image_name = list(img_label.keys())
    label = list(img_label.values())
    for images, path, height, width in tqdm(dataloader):
        path = path[0]
        cate = path.split("/")[-2]
        name = path.split("/")[-1].split(".")[0]

        with jt.no_grad():

            out = model(images, mode="clssification")
            images_h = jt.flip(images, dim=(3,))
            out_h = model(images_h, mode="clssification")
            output = (out + out_h) / 2
            values, indices = jt.topk(output[0], k=1)
            values2, indices2 = jt.topk(output[0], k=2)
            path_0=os.path.join(cate, name + ".JPEG")
            labels=img_label[path_0]
            labels=jt.Var(labels)
            loss = nn.cross_entropy_loss(output, labels, reduction=False)
            lossall=lossall+loss

            # save generated labels

            labeled.append("{0} {1} {2} {3}".format(path_0, indices,values,loss))
            labeled2.append("{0} {1}".format(path_0, indices))

            jt.clean_graph()
            jt.sync_all()
            jt.gc()

    with open(os.path.join(args.dump_path, "train_all.txt"), "w") as f:
        f.write("\n".join(labeled))

    print('loss avg:',lossall/len(img_label))






if __name__ == "__main__":
    args = parse_args()
    main_worker(args=args)