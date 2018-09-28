// Run using : dart reverse-string.dart hello-world
void main(List<String> args) {
    print( reverse(args[0]) );
}
String reverse(input) {
    return input.split('').reversed.join();
}