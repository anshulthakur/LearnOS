/**MOD+***********************************************************************/
/* Module:    hello-2.c	                                                     */
/*                                                                           */
/* Purpose:   Demonstrating the use of names other than init_module and      */
/*				cleanup_module in module design								 */
/*                                                                           */
/**MOD-***********************************************************************/

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>

static int __init hello_2_init(void)
{
	printk(KERN_INFO "Hello, World 2\n");
	//Must be zero for success
	return 0;
}


static void __exit hello_2_exit(void)
{
	printk(KERN_INFO "Goodbye, World 2\n");
}

module_init(hello_2_init);
module_exit(hello_2_exit);
