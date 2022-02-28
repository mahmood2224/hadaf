
String convertNumbersString(String src, {String divider = ","}) {
  src= src.trim();
  String fractions = "" ;
  if(src.contains(".")){
    final srcSplit = src.split(".");
    src = srcSplit[0];
    fractions = ".${srcSplit[1]}" ;
  }
  if (src.length > 3) {
    int counter = 0 ;
    String convercedString ='' ;
    for(int i = src.length-1 ; i >= 0 ; i--){
       if(counter== 3 ){
         counter= 0 ;
         convercedString+=divider ;
       }
       convercedString+=src[i];
       counter++ ;
    }
    return converseString(convercedString)+fractions ;
  }
  return src+fractions;
}
String converseString(String src){
  String result = '' ;
  for(int i = src.length-1 ; i >= 0 ; i--){
    result+=src[i];
  }
  return result ;
}



void main() {
  print(convertNumbersString("4000.50"));
}
