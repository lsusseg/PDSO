#rm -r output
export DISABLE_MULTIPROCESSING=1
#export DISABLE_MULTIPROCESSING=1
#CUDA_VISIBLE_DEVICES='0' python amg.py --checkpoint ./checkpoint/sam_vit_b_01ec64.pth --model-type vit_b --input ./input --output ./output


###auto模式###
#CUDA_VISIBLE_DEVICES='GPU-21e2657c-9595-acd4-9d07-ad0b20c3f892' python amg_auto.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /home/litingting/wwjj/bisai_all/SAM/input \
#--output /home/litingting/wwjj/bisai_all/SAM/output

#CUDA_VISIBLE_DEVICES='7' python amg_auto.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /data/jittor/ImageNetS/ImageNetS/ImageNetS50/validation/ \
#--output /farm/litingting/jittor/sam/val_new/

###在mask区域的显著图中找最亮点####
#CUDA_VISIBLE_DEVICES='5' python amg_maskpoint.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /data/jittor/ImageNetS/ImageNetS/ImageNetS50/validation/ \
#--output /farm/litingting/jittor/segment-anything-jittor/sam/val_point_mask_pixel_finetuning_400_未校正_3 \
#--output_1 /farm/litingting/jittor/segment-anything-jittor/data/val_point_mask_pixel_finetuning_400_未校正/ \
#--mask /farm/litingting/jittor/resnet_fcn/scripts/weights_epoch1000/pass50/pixel_finetuning_400_未校正/validation/ \
#--radius 59


####输入框作为前景####
#CUDA_VISIBLE_DEVICES='5' python amg_box.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /farm/litingting/jittor/resnet/bisai_resnet18/test \
#--output /farm/litingting/jittor/segment-anything-jittor/sam/test_box_pixel_finetuning_400_未校正_1/ \
#--output2 /farm/litingting/jittor/segment-anything-jittor/data/test_box_pixel_finetuning_400_未校正_single/ \
#--mask /farm/litingting/jittor/resnet_fcn/scripts/weights_epoch1000/pass50/pixel_finetuning_400_未校正/test/

#--output2 /farm/litingting/jittor/segment-anything-jittor/data/val_box_pixel_finetuning_400_未校正_3/ \


####输入点（logit-max）作为前景####
#CUDA_VISIBLE_DEVICES='8' python amg_point.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /data/jittor/ImageNetS/ImageNetS/ImageNetS50/validation \
#--output /farm/litingting/jittor/segment-anything-jittor/sam-point/val_point_cluster_single


####输入点（logit-max）+框作为前景####
#CUDA_VISIBLE_DEVICES='8' python amg_box_point.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /farm/litingting/jittor/resnet_fcn/test/ \
#--output /farm/litingting/jittor/segment-anything-jittor/sam-box-point/test_box-point_cluster_single \
#--mask /farm/litingting/jittor/resnet_fcn/scripts/weights_epoch1000/pass50/pixel_finetuning_400_未校正/test/

#CUDA_VISIBLE_DEVICES='9' python amg_box_point_gai.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /data/jittor/ImageNetS/ImageNetS/ImageNetS50/train \
#--output /farm/litingting/jittor/segment-anything-jittor/sam-box-point-gai/pixel_finetuning_400/sam-mask/train_box-point-gai_cluster_1 \
#--mask /farm/litingting/jittor/resnet_fcn/scripts/weights_epoch1000/pass50/pixel_finetuning_400/train/
#
#CUDA_VISIBLE_DEVICES='9' python amg_box_point.py \
#--checkpoint ./checkpoint/sam_vit_b_01ec64.pth \
#--model vit_b \
#--input /data/jittor/ImageNetS/ImageNetS/ImageNetS50/train \
#--output /farm/litingting/jittor/segment-anything-jittor/sam-box-point/pixel_finetuning_400/sam-mask/train_box-point_cluster_3 \
#--mask /farm/litingting/jittor/resnet_fcn/scripts/weights_epoch1000/pass50/pixel_finetuning_400/train


CUDA_VISIBLE_DEVICES=6 python /farm/litingting/wwjj/lw925/chuli/SAM-jittor/amg_box_point.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/validation \
--output /farm/litingting/wwjj/lw925/e400-PASS-jittor-ASP/weights/pass50/pixel_attention/sam-val2  \
--mask /farm/litingting/wwjj/lw925/e400-PASS-jittor/weights/pass50/pixel_attention/validation_infer \
--txt1_path /farm/litingting/wwjj/lw925/e400-PASS-jittor-ASP/weights/pass50/pixel_attention/valPoint.txt

CUDA_VISIBLE_DEVICES=6 python /farm/litingting/wwjj/lw925/chuli/SAM-jittor/amg_box_point_oneclass_manyrect.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/validation \
--output /farm/litingting/wwjj/lw925/e400-PASS-jittor-ASP/weights/pass50/pixel_attention/sam-val4  \
--mask /farm/litingting/wwjj/lw925/e400-PASS-jittor/weights/pass50/pixel_attention/validation_infer \
--txt1_path /farm/litingting/wwjj/lw925/e400-PASS-jittor-ASP/weights/pass50/pixel_attention/valPoint.txt \
--txt_path_class /farm/litingting/wwjj/lw925/e400-PASS-jittor/weights/pass50/pixel_attention/cluster/val_I_D.txt

CUDA_VISIBLE_DEVICES=6 python /farm/litingting/wwjj/lw925/chuli/SAM-jittor/amg_box_point_muticlass_manyrect.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/validation \
--output /farm/litingting/wwjj/lw925/e400-PASS-jittor-ASP/weights/pass50/pixel_attention/sam-val6  \
--mask /farm/litingting/wwjj/lw925/e400-PASS-jittor/weights/pass50/pixel_attention/validation_infer \
--txt1_path /farm/litingting/wwjj/lw925/e400-PASS-jittor-ASP/weights/pass50/pixel_attention/valPoint.txt \
--txt_path_class /farm/litingting/wwjj/lw925/e400-PASS-jittor/weights/pass50/pixel_attention/cluster/val_I_D.txt

CUDA_VISIBLE_DEVICES=7 python /farm/litingting/wwjj/lw925/chuli/SAM-jittor/amg_box_point_muticlass_manyrect.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/train \
--output /farm/litingting/wwjj/lw925/e400-PASS-jittor-DFF-CSD-APS/weights/pass50/pixel_attention/sam-train-0.65  \
--mask /farm/litingting/wwjj/lw925/e400-PASS-jittor-DFF-CSD-APS/weights/pass50/pixel_attention/train \
--txt1_path /farm/litingting/wwjj/lw925/e400-PASS-jittor-DFF-CSD-APS/weights/pass50/pixel_attention/trainPoint.txt \
--txt_path_class /farm/litingting/wwjj/lw925/e400-PASS-jittor-DFF-CSD-APS/weights/pass50/pixel_attention/cluster/trainall_I_D_50.txt \
--outputbox /farm/litingting/wwjj/lw925/e400-PASS-jittor-DFF-CSD-APS/weights/pass50/pixel_attention/trainbox_0.65 \
--yz 0.65


CUDA_VISIBLE_DEVICES=6 python /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD-APF/SAM-jittor/amg_box_point_muticlass_manyrect.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/validation \
--output /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD-APF/weights/pass50/pixel_attention/sam-train-0.65-2  \
--output_255 /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD-APF/weights/pass50/pixel_attention/sam-train-0.65-255  \
--mask /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD-APF/weights/pass50/pixel_attention/validation \
--txt1_path /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-APF/weights/pass50/pixel_attention/valPoint.txt \
--txt_path_class /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-APF/weights/pass50/pixel_attention/cluster/val_I_D_50.txt \
--outputbox /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD-APF/weights/pass50/pixel_attention/trainbox_0.65 \
--yz 0.65

CUDA_VISIBLE_DEVICES=7 python /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD/SAM-jittor/cld.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/validation \
--output /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD/weights/pass50/pixel_attention/sam-val-0.65  \
--output_255 /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD/weights/pass50/pixel_attention/sam-val-0.65-255  \
--mask /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD/weights/pass50/pixel_attention/validation \
--txt_path_class /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD/weights/pass50/pixel_attention/cluster/val_I_D_50.txt \
--outputbox /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD/weights/pass50/pixel_attention/valbox_0.65 \
--yz 0.65


CUDA_VISIBLE_DEVICES=6 python /farm/litingting/wwjj/lw1114/e400-PASS-jittor-DFF-CLD-APF/SAM-jittor/cld-apf.py \
--checkpoint /farm/litingting/wwjj/lw925/chuli/SAM-jittor/checkpoint/sam_vit_b_01ec64.pth \
--model vit_b \
--input  /farm/litingting/wwjj/lw925/ImageNetS50/train \
--output /farm/litingting/wwjj/lw1114/e400-PASS-jittor/weights/pass50/pixel_attention/sam/sam-train-0.5-apf-cld  \
--output_255 /farm/litingting/wwjj/lw1114/e400-PASS-jittor/weights/pass50/pixel_attention/sam/sam-train-0.5-255-apf-cld  \
--mask /farm/litingting/wwjj/lw1114/e400-PASS-jittor/weights/pass50/pixel_attention/train \
--txt1_path /farm/litingting/wwjj/lw1114/e400-PASS-jittor/weights/pass50/pixel_attention/trainPoint.txt \
--txt_path_class /farm/litingting/wwjj/lw1114/e400-PASS-jittor/weights/pass50/pixel_attention/cluster/train_I_D_50.txt \
--outputbox /farm/litingting/wwjj/lw1114/e400-PASS-jittor/weights/pass50/pixel_attention/sam/trainbox_0.5-apf-cld \
--yz 0.5
