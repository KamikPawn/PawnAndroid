forward OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

native SetTimer(funcname[], interval, repeating);
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

}

f0(arr[]) {
	#pragma unused arr
}

f1(arr[]) { // line 13
 	new a = arr[0];
 	#pragma unused a
}

f2(arr[5]) {// line 18
	new a = arr[0];
    #pragma unused a
}
f3(const arr[]) {
    new a = arr[0];
    #pragma unused a
}
f4(const arr[5]) {
    new a = arr[0];
    #pragma unused a
}
f5(arr[][]) { // line 30
	new a = arr[0][0];
	#pragma unused a
}
f6(arr[][]) {
	arr[0][0] = 0;
}

main () {
	f0("test"); // line 39
	f1("test"); // line 40
	f2("test"); // line 41
	f3("test");
	f4("test");

	new arr[5];
	f1(arr);
	f2(arr);
	f3(arr);
	f4(arr);

	f1(arr[0]);
	//f2(arr[0]); - array size must match
	f3(arr[0]);
	//f4(arr[0]); - array size must match

	new arr2[1][1];
	f5(arr2);
	f6(arr2);

	SetTimer("test", 0, 0);
}
