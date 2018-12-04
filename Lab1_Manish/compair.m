clear;
sentWord = randi([0,1], [125000, 8]);
codifiedWord = hjCodify(sentWord);
hjGraphic

hold on

aux = [sentWord(:,1:4); sentWord(:,5:8)];
sentWord = aux;
codifiedWord = hammingCodify(sentWord);
hammingGraphic

loglog(p,p)

set(gca,'Xdir','reverse')
legend('hj', 'hamming', 'direta')
grid on
xlabel('Probabilidade de erro do canal')
ylabel('Probabilidade de erro da transmiss�o')