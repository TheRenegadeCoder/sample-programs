class FizzBuzz {
	static public function main():Void {
		for (i in 1...101) {
			var div3 = (i % 3 == 0);
			var div5 = (i % 5 == 0);
			Sys.println(div3 ? (div5 ? "FizzBuzz" : "Fizz") : (div5 ? "Buzz" : '$i'));
		}
	}
}
