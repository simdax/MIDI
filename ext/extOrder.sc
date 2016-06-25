// + SequenceableCollection{
// 	order{
// 		var b=this.copy;
// 		var a=b.copy.sort;
// 		var c;
// 		a.size.do{ arg x;
// 			var res=b.indexOf(a[x]); b[res]=nil;
// 			c=c.add(res)
// 		};
// 		^c
// 	}
// }