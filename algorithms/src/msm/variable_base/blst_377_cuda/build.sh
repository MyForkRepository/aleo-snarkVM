#!/bin/bash

nvcc ./asm_cuda.cu -ptx -rdc=true -o ./asm_cuda.release.ptx
nvcc ./blst_377_ops.cu -ptx -rdc=true -o ./blst_377_ops.release.ptx
nvcc ./msm.cu -ptx -rdc=true -o ./msm.release.ptx

nvcc ./asm_cuda.cu --device-debug -ptx -rdc=true -o ./asm_cuda.debug.ptx
nvcc ./blst_377_ops.cu --device-debug -ptx -rdc=true -o ./blst_377_ops.debug.ptx
nvcc ./msm.cu --device-debug -ptx -rdc=true -o ./msm.debug.ptx
nvcc ./tests.cu --device-debug -ptx -rdc=true -o ./tests.debug.ptx

# Build msm.fatbin
nvcc ./asm_cuda.cu ./blst_377_ops.cu ./msm.cu -gencode=arch=compute_52,code=sm_52 -gencode=arch=compute_53,code=sm_53 -gencode=arch=compute_60,code=sm_60 -gencode=arch=compute_61,code=sm_61 -gencode=arch=compute_62,code=sm_62 -gencode=arch=compute_70,code=sm_70 -gencode=arch=compute_72,code=sm_72 -gencode=arch=compute_75,code=sm_75 -gencode=arch=compute_80,code=sm_80 -gencode=arch=compute_86,code=sm_86 -gencode=arch=compute_87,code=sm_87 -dlink -fatbin -o ./msm.fatbin

# Build test.fatbin
nvcc ./asm_cuda.cu ./blst_377_ops.cu ./tests.cu ./msm.cu -gencode=arch=compute_52,code=sm_52 -gencode=arch=compute_53,code=sm_53 -gencode=arch=compute_60,code=sm_60 -gencode=arch=compute_61,code=sm_61 -gencode=arch=compute_62,code=sm_62 -gencode=arch=compute_70,code=sm_70 -gencode=arch=compute_72,code=sm_72 -gencode=arch=compute_75,code=sm_75 -gencode=arch=compute_80,code=sm_80 -gencode=arch=compute_86,code=sm_86 -gencode=arch=compute_87,code=sm_87 --device-debug -dlink -fatbin -o ./test.fatbin
