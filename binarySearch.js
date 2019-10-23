function bs(arr,val)
{
	var ub=0;
	var lb=arr.length;	

	while (lb>=ub)
	{
		var mid=(ub+lb)/2;
		if(val==arr[mid])
		{
			return mid;
		}
		else 
			if(val>arr[mid])
			{
				ub=mid+1;
			}	
			else 
				{
					lb=mid-1;
				}
	}
	return -1;

}

var arr = [1,2,3,4,5,6];
var val=7;

if(bs(arr,val)==-1)
{
	document.write("ELEMENT NOT FOUND!");
}
else
{
	document.write("ELEMENT FOUND!");
}

