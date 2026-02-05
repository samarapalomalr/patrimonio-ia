#include <jni.h>
#include <string>

#include "edge-impulse-sdk/classifier/ei_run_classifier.h"

extern "C"
JNIEXPORT jstring JNICALL
Java_br_com_samara_patrimonio_1ia_MainActivity_runModel(
        JNIEnv* env,
        jobject /* this */) {

    return env->NewStringUTF("Edge Impulse JNI funcionando");
}
