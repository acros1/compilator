/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Alex/OneDrive - insa-toulouse.fr/Cours/4IR/S2/PSI/processor/instructionMemory.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);


static void work_a_0123541133_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t5;
    unsigned int t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(48, ng0);

LAB3:    t1 = xsi_get_transient_memory(8192U);
    memset(t1, 0, 8192U);
    t2 = t1;
    t3 = (t0 + 14117);
    t5 = (32U != 0);
    if (t5 == 1)
        goto LAB5;

LAB6:    t7 = (t0 + 14149);
    memcpy(t2, t7, 32U);
    t2 = (t2 + 32U);
    t9 = (t0 + 3320);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 8192U);
    xsi_driver_first_trans_fast(t9);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

LAB5:    t6 = (8192U / 32U);
    xsi_mem_set_data(t2, t3, 32U, t6);
    goto LAB6;

}

static void work_a_0123541133_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    int t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;

LAB0:    t1 = (t0 + 2920U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(55, ng0);

LAB6:    t2 = (t0 + 3240);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    t6 = (t0 + 3240);
    *((int *)t6) = 0;
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1512U);
    t4 = *((char **)t2);
    t2 = (t0 + 1032U);
    t6 = *((char **)t2);
    t2 = (t0 + 5844U);
    t10 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t6, t2);
    t11 = (t10 - 0);
    t12 = (t11 * 1);
    xsi_vhdl_check_range_of_index(0, 255, 1, t10);
    t13 = (32U * t12);
    t14 = (0 + t13);
    t7 = (t4 + t14);
    t15 = (t0 + 3384);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t7, 32U);
    xsi_driver_first_trans_fast_port(t15);
    goto LAB2;

LAB5:    t4 = (t0 + 1152U);
    t5 = xsi_signal_has_event(t4);
    if (t5 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 == 1)
        goto LAB4;
    else
        goto LAB6;

LAB7:    goto LAB5;

LAB8:    t6 = (t0 + 1192U);
    t7 = *((char **)t6);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t3 = t9;
    goto LAB10;

}


extern void work_a_0123541133_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0123541133_3212880686_p_0,(void *)work_a_0123541133_3212880686_p_1};
	xsi_register_didat("work_a_0123541133_3212880686", "isim/testPipeline_isim_beh.exe.sim/work/a_0123541133_3212880686.didat");
	xsi_register_executes(pe);
}
