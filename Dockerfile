# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# NOTE: All custom nodes in the provided workflow are listed under unknown_registry and have no aux_id or registry ID.
#       Therefore they cannot be installed via `comfy node install` or git clone automatically.
#       The workflow contains 73 custom node instances (unique node types are listed below). Provide the missing aux_id / registry IDs
#       if you want these installed automatically.
# Unique node types present in workflow (not installable automatically - aux_id / cnrId missing):
# Mute / Bypass Repeater (rgthree)
# PreviewImage
# DepthAnythingPreprocessor
# CannyEdgePreprocessor
# ControlNetApplyAdvanced
# Anything Everywhere3
# KSampler Adv. (Efficient)
# Sampler Selector
# Scheduler Selector
# Cfg Literal
# Int Literal
# UltimateSDUpscale
# SDLoraSelector
# SDLoraLoader
# HintImageEnchance
# Text to Conditioning
# Anything Everywhere
# SDPromptSaver
# LoadImage
# DWPreprocessor
# ControlNetLoader
# workflow/Scribble
# UpscaleModelLoader
# LoraInfo
# CR SDXL Aspect Ratio
# Fast Bypasser (rgthree)
# UltralyticsDetectorProvider
# CR Image Input Switch
# CheckpointLoaderSimple
# CheckpointNameSelector
# Seed Generator
# FaceDetailer
# LoraLoaderStackedVanilla
# Efficient Loader
# SeargePromptText
# KepStringLiteral
# Scheduler Selector (Image Saver)
# String Literal

# download models into comfyui
RUN comfy model download --url https://huggingface.co/spaces/LiheYoung/Depth-Anything/blob/main/checkpoints/depth_anything_vitl14.pth --relative-path models/checkpoints --filename depth_anything_vitl14.pth
RUN comfy model download --url https://huggingface.co/ckpt/chilloutmix/blob/main/chilloutmix_NiPrunedFp32Fix.safetensors --relative-path models/checkpoints --filename chilloutmix_NiPrunedFp32Fix.safetensors
RUN comfy model download --url https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors --relative-path models/vae/SDXL --filename sdxl_vae.safetensors
RUN comfy model download --url https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors --relative-path models/controlnet/SDXL --filename OpenPoseXL2.safetensors
RUN comfy model download --url https://huggingface.co/TTPlanet/TTPLanet_SDXL_Controlnet_Tile_Realistic/resolve/main/TTPLANET_Controlnet_Tile_realistic_v2_fp16.safetensors --relative-path models/controlnet/SDXL --filename TTPLANET_Controlnet_Tile_realistic_v2_fp16.safetensors
RUN comfy model download --url https://huggingface.co/TencentARC/t2i-adapter-canny-sdxl-1.0/resolve/main/diffusion_pytorch_model.fp16.safetensors --relative-path models/controlnet/SDXL --filename t2i-adapter-canny-sdxl-1.0.fp16.safetensors
RUN comfy model download --url https://huggingface.co/TencentARC/t2i-adapter-depth-zoe-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors --relative-path models/controlnet/SDXL --filename t2i-adapter-depth-zoe-sdxl-1.0.safetensors
RUN comfy model download --url https://huggingface.co/diffusers/stable-diffusion-xl-1.0-inpainting-0.1/resolve/main/unet/diffusion_pytorch_model.safetensors --relative-path models/controlnet/SDXL --filename diffusion_pytorch_model.safetensors
RUN comfy model download --url https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth --relative-path models/upscale_models --filename 4x_NMKD-Siax_200k.pth
RUN comfy model download --url https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt --relative-path models/ultralytics/bbox --filename face_yolov8n_v2.pt
# RUN # Could not find URL for Pony\Elimination\ssugar008_mm-000010.safetensors
# RUN # Could not find URL for Animal\Chartreux-000002.safetensors
# RUN # Could not find URL for Pony\Action\straddling_handjob_v0.1-pony.safetensors
# RUN # Could not find URL for yolox_l.torchscript.pt
# RUN # Could not find URL for dw-ll_ucoco_384_bs5.torchscript.pt
# RUN # Could not find URL for waiREALCN_v110.safetensors
# RUN # Could not find URL for Pony\Elimination\milk_girl-000010.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
