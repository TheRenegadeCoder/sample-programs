function SelectionSort(&$data, $count) {
	for ($i = 0; $i < $count - 1; $i++)
	{
		$min = $i;

		for ($j = $i + 1; $j < $count; $j++)
		{
			if ($data[$j] < $data[$min])
			{
				$min = $j;
			}
		}

		$temp = $data[$min];
		$data[$min] = $data[$i];
		$data[$i] = $temp;
	}
}
