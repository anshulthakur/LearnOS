/**MOD+***********************************************************************/
/* Module:    hello-1.c	                                                     */
/*                                                                           */
/* Purpose:   A simple Kernel Module.						                 */
/*                                                                           */
/**MOD-***********************************************************************/

#include <linux/module.h>
#include <linux/kernel.h>

int init_module(void)
{
	printk(KERN_INFO "Hello World! 1.\n");

	return 0;
}

void cleanup_module(void)
{
	printk(KERN_INFO "Goodbye world! 1.\n");
}
