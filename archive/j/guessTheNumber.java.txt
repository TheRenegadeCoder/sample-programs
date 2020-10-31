class A
{
	public static void main(String args[])
	{
		int a[]=new int[15];
		for(int i=0;i<a.length;i++)
		{
			a[i]=(int)(Math.random()*25);
		
		System.out.println("a["+i+"]:"+a[i]);
		}
		int lottery=(int)(Math.random()*25);
		System.out.println("winner numbers are:-"+lottery);
		for(int i=0;i<a.length;i++)
		{
			if(a[i]==lottery)
			{
				System.out.print(i+",");
			}
		}
	}
	}