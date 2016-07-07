(

var val="ronde blanche noire croche double"
//"double croche noire blanche ronde"
.split($ );

/// routine pour affichage des val solfegique
~solf={r{
	arg inval;
	var poin=2;
	loop{
		inval=if(inval.isNil or: (inval==inf) or: (inval==0))
			{nil}
			{poin=poin-log2(inval).round;
			val[poin]}
		.yield
	}
}};

/// lyli code

a=r{
	arg inval;
	var score;
	loop{
		score=score.add(
			"c"++(2.pow(val.detectIndex(_==inval)))
		);
		inval=score.yield
	}
};


)

