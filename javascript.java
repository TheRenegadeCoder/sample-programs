<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>JavaSctipt Calculator | Web Dev Trick</title>
	<link rel="stylesheet" href="style.css">
</head>

<body>
	<script>
	function calcNumbers(result){
		form.displayResult.value=form.displayResult.value+result;
		
	}
	</script>
	<div class="container">
		<form name="form">
		<div class="display">
			<input type="text" placeholder="0" name="displayResult" />
		</div>
			<div class="buttons">
			  <div class="row">
				<input type="button" name="b7" value="7" onClick="calcNumbers(b7.value)">
				  <input type="button" name="b8" value="8" onClick="calcNumbers(b8.value)">
				  <input type="button" name="b9" value="9" onClick="calcNumbers(b9.value)">
				  <input type="button" name="addb" value="+" onClick="calcNumbers(addb.value)">
				</div>
				
				<div class="row">
				<input type="button" name="b4" value="4" onClick="calcNumbers(b4.value)">
				  <input type="button" name="b5" value="5" onClick="calcNumbers(b5.value)">
				  <input type="button" name="b6" value="6" onClick="calcNumbers(b6.value)">
				  <input type="button" name="subb" value="-" onClick="calcNumbers(subb.value)">
				</div>
				
				<div class="row">
				<input type="button" name="b1" value="1" onClick="calcNumbers(b1.value)">
				  <input type="button" name="b2" value="2" onClick="calcNumbers(b2.value)">
				  <input type="button" name="b3" value="3" onClick="calcNumbers(b3.value)">
				  <input type="button" name="mulb" value="*" onClick="calcNumbers(mulb.value)">
				</div>
				
				<div class="row">
				<input type="button" name="b0" value="0" onClick="calcNumbers(b0.value)">
				  <input type="button" name="potb" value="." onClick="calcNumbers(potb.value)">
				  <input type="button" name="divb" value="/" onClick="calcNumbers(divb.value)">
				  <input type="button" class="red" value="=" onClick="displayResult.value=eval(displayResult.value)">
				</div>
			</div>
		
		</form>
	</div>
</body>
	
</html>