$$
\newcommand{\not}{\overline}
$$
- Equality Logic With Uninterpreted Functions: EUF が SMT を含む

## SAT: SATisfiability Problem
$((a\land\not b\land\not c)\lor(b\land c\land\not d))\land(\not b\lor\not c)$
$(a,b,c,d)=(t,f,f,t)$
### DPLL: Davis Putnam Logemann Loveland

### CDCL: Constrait-Driven Clause Learning

## SMT: Satisfiability Modulo Theories
FOL: First-Order Logic
HOL: Higher-Order Logic

### Bit Vectors

### DPLL(T)
SMT ソルバ全般
[SAT/SMTソルバの仕組み](https://www.slideshare.net/sakai/satsmt)
 	SAT, SMT について主要なアルゴリズムや technique をまとめてある
 	Theory Combination についていろいろ書いてあって助かる。例えば Convexity について（スライド 44）
 [SAT ソルバ・SMT ソルバの技術と応用](https://www.jstage.jst.go.jp/article/jssst/27/3/27_3_3_24/_pdf)
 	サーベイ論文たすかる
 [A Survey of Satisfiability Modulo Theory](https://arxiv.org/abs/1606.04786)
 	サーベイ論文たすかる2
[* SMT-LIBv2]（SMT ソルバの入力の形式）
[The SMT-LIBv2 Language and Tools: A Tutorial](http://smtlib.github.io/jSMTLIB/SMTLIBTutorial.pdf)
 	p20. SMT-LIBv2 の token が表になって並んでおり、どのような正規表現でマッチさせられるか掲載している
[SMT-LIB The Satisfiability Modulo Theories Library](http://smtlib.cs.uiowa.edu/)
 	SMT ソルバに与える入力の形式 SMT-LIB v2 についてまとまっている Web サイト

## EUF: Equality Logic With Uninterpreted Functions
 [SMT: Equality Logic With Uninterpreted Functions](https://www21.in.tum.de/teaching/sar/SS20/6.pdf)
		[ミュンヘン工科大学の夏学期の自動推論に関する授業](https://www21.in.tum.de/teaching/sar/SS20/) の資料で、EUF だけでなく CDCL から Bit Vectors に関する話までいろいろ PDF が用意されている
	SMT-LIB-benchmarks / QF_UF · GitLab https://clc-gitlab.cs.uiowa.edu:2443/SMT-LIB-benchmarks/QF_UF
		QF_UF のベンチマーク用入力が大量に用意されている


[参考資料まとめ - smt-d (scrapbox.io)](https://scrapbox.io/smt-d/%E5%8F%82%E8%80%83%E8%B3%87%E6%96%99%E3%81%BE%E3%81%A8%E3%82%81)
[_pdf (jst.go.jp)](https://www.jstage.jst.go.jp/article/jssst/27/3/27_3_3_24/_pdf)


形式手法
- モデル検査
- 定理証明支援系