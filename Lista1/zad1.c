
#include <stdio.h>
#include <float.h>

int main(void) {
    printf("========== FLOAT (Float32) ==========\n");
    printf("FLT_EPSILON: %.9e\n", (double)FLT_EPSILON);
    printf("FLT_MIN:     %.9e\n", (double)FLT_MIN);
    printf("FLT_MAX:     %.9e\n", (double)FLT_MAX);
    printf("Bity mantysy: %d\n", FLT_MANT_DIG);

    printf("\n========== DOUBLE (Float64) ==========\n");
    printf("DBL_EPSILON: %.17e\n", DBL_EPSILON);
    printf("DBL_MIN:     %.17e\n", DBL_MIN);
    printf("DBL_MAX:     %.17e\n", DBL_MAX);
    printf("Bity mantysy: %d\n", DBL_MANT_DIG);

    return 0;
}
