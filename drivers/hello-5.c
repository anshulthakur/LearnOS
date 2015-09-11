/**MOD+***********************************************************************/
/* Module:    hello-5.c	                                                     */
/*                                                                           */
/* Purpose:   												                 */
/*                                                                           */
/* (C) COPYRIGHT CDOT-Delhi 2013			                                 */
/*                                                                           */
/**MOD-***********************************************************************/

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/moduleparam.h>
#include <linux/stat.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("ANSHUL THAKUR");
MODULE_SUPPORTED_DEVICE("Dummy");

static short int myshort=1;
static int myint=10;
static long int mylong = 456891;
static char * mychar="parara";
static int myintarray[3]= {1,4,6};
static int arr_argc = 0;

module_param(myshort, short, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(myshort, "This is a short integer");
module_param(myint, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(myint, "This is a normal integer");
module_param(mylong, long, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(mylong, "A long integer");
module_param(mychar, charp, 0000);
MODULE_PARM_DESC(mychar,"A character array");

module_param_array(myintarray, int, &arr_argc, 0000);
MODULE_PARM_DESC(myintarray,"Integer array");


static int __init hello_5_init(void)
{
	int i=0;
	printk(KERN_INFO "Hello World 5! \n");
	printk(KERN_INFO "This is a short int %hd\n", myshort);
	printk(KERN_INFO "This is an int %d\n", myint);
	printk(KERN_INFO "This is a long int %ld\n", mylong);
	printk(KERN_INFO "This is a character string %s\n", mychar);
	for(i;i<arr_argc;i++)
	{
		printk(KERN_INFO "myintarray[%d] = %d\n", i, myintarray[i]);
	}
	printk(KERN_INFO "Got %d parameters in input\n", arr_argc);

	return 0;
}

static void __exit hello_5_exit(void)
{
	printk(KERN_INFO "Goodbye World! 5\n");
}

module_init(hello_5_init);
module_exit(hello_5_exit);



