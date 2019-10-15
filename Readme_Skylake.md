Build from the sources tensorflow 2.0.0 package failed on skylake CPU architecture system with  following error code:
```
tensorflow/lite/experimental/ruy/kernel_avx512.cc:161:32: error: ‘_mm512_loadu_epi32’ was not declared in this scope
_mm512_loadu_epi32(&params.lhs_sums[row]));
^~~~~~~~~~~~~~~~~~
```
Please, note that you can bypass using AVX-512 instructions and get a successful build by changing:

`/tensorflow/tensorflow/lite/experimental/ruy/platform.h`

Relpace lines 55-61 from original file:
```
// TODO(b/138433137) Select AVX-512 at runtime rather than via compile options.
#if defined(__AVX512F__) && defined(__AVX512DQ__) && defined(__AVX512CD__) && \
    defined(__AVX512BW__) && defined(__AVX512VL__)
#define RUY_DONOTUSEDIRECTLY_AVX512 1
#else
#define RUY_DONOTUSEDIRECTLY_AVX512 0
#endif
```
With below code:
```
// TODO(b/138433137) Select AVX-512 at runtime rather than via compile options.
/* #if defined(__AVX512F__) && defined(__AVX512DQ__) && defined(__AVX512CD__) && \ */
/*     defined(__AVX512BW__) && defined(__AVX512VL__) */
/* #define RUY_DONOTUSEDIRECTLY_AVX512 1 */
/* #else */
#define RUY_DONOTUSEDIRECTLY_AVX512 0 */
/* #endif */
```
Use following sed commands to change:
```
sed -e '56,59 s/.*/\/* & \*\//; 61 s/.*/\/* & \*\//' /tensorflow/tensorflow/lite/experimental/ruy/platform.h

sed -i '56,59 s/.*/\/* & \*\//; 61 s/.*/\/* & \*\//' /tensorflow/tensorflow/lite/experimental/ruy/platform.h

sed -n '55,61p' /tensorflow/tensorflow/lite/experimental/ruy/platform.h
```

Or change under section i9-7940X in auto_build.sh before running tflow-build.sh from this repo as following:
```
i9-7940X)
           echo "Building Tensorflow Package For $CPU"
           WHL_DIR=/whl
           HOME=/home/jenkins
           sed -i '56,59 s/.*/\/* & \*\//; 61 s/.*/\/* & \*\//' /tensorflow/tensorflow/lite/experimental/ruy/platform.h
           sed -n '55,61p' /tensorflow/tensorflow/lite/experimental/ruy/platform.h
           bazel build --config=opt \
           --config=cuda \
           --config=mkl \
           --config=noaws \
           --config=nohdfs \
           --config=noignite \
           --config=nokafka \
           --copt=-msse4.1 \
           --copt="-DEIGEN_USE_VML" \
           --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" \
            //tensorflow/tools/pip_package:build_pip_package && \
            mkdir ${WHL_DIR} && \
            bazel-bin/tensorflow/tools/pip_package/build_pip_package ${WHL_DIR}
                ;;
```

References:

https://github.com/tensorflow/tensorflow/issues/32026

https://github.com/Huawei-MRC-OSI/tensorflow/commit/c45d98ba2d92fcbf9ceb6baea13fbfc68ef1a1f7#diff-d008044806750fc43064c633ff70cb12
