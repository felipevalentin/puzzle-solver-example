% Fatos.
presilha(amarela).
presilha(azul).
presilha(branca).
presilha(verde).
presilha(vermelha).

nome(andressa).
nome(graziela).
nome(maria).
nome(sonia).
nome(tamires).

luta(capoeira).
luta(carate).
luta(jiujitsu).
luta(judo).
luta(muaythai).

idade(20).
idade(25).
idade(30).
idade(35).
idade(40).

estado(espiritosanto).
estado(goias).
estado(parana).
estado(pernambuco).
estado(tocantins).

hobby(cantar).
hobby(cozinhar).
hobby(dancar).
hobby(pintar).
hobby(ler).

% X está à ao lado de Y.
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).

% X está à esquerda de Y, em qualquer posição à esquerda.
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
% X está à direita de Y, em qualquer posição à direita.
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista).

% X está entre Y e Z, nessa ordem.
entre(X,Y,Z,Lista):- aEsquerda(Y,X,Lista), aDireita(Z,X,Lista).

% X está no canto se ele é o primeiro ou o último da lista.
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :- 
    ListaSolucao = [
        lutadora(Presilha1, Nome1, Luta1, Idade1, Estado1, Hobby1),
        lutadora(Presilha2, Nome2, Luta2, Idade2, Estado2, Hobby2),
        lutadora(Presilha3, Nome3, Luta3, Idade3, Estado3, Hobby3),
        lutadora(Presilha4, Nome4, Luta4, Idade4, Estado4, Hobby4),
        lutadora(Presilha5, Nome5, Luta5, Idade5, Estado5, Hobby5)
    ],

    % A moça de 20 anos está ao lado da lutadora de 25 anos.
    aoLado(lutadora(_,_,_,20,_,_), lutadora(_,_,_,25,_,_), ListaSolucao),

    % A lutadora de Recife está em algum lugar à direita da lutadora de presilha Vermelha.
    aDireita(lutadora(_,_,_,_,pernambuco,_), lutadora(vermelha,_,_,_,_,_), ListaSolucao),

    % Maria está em algum lugar entre a mulher do Espírito Santo e a mulher de presilha Vermelha, nessa ordem.
    entre(lutadora(_,maria,_,_,_,_), lutadora(_,_,_,_,espiritosanto,_), lutadora(vermelha,_,_,_,_,_),  ListaSolucao),

    % A Paranaense está em algum lugar entre a lutadora de 35 anos e a lutadora que pratica Jiu-jítsu, nessa ordem.
    entre(lutadora(_,_,_,_,parana,_), lutadora(_,_,_,35,_,_), lutadora(_,_,jiujitsu,_,_,_), ListaSolucao),

    % A mulher de 30 anos está ao lado da mulher mais nova.
    aoLado(lutadora(_,_,_,30,_,_), lutadora(_,_,_,20,_,_), ListaSolucao),

    % Quem gosta de Cozinhar está usando uma presilha Branca.
    member(lutadora(branca,_,_,_,_,cozinhar), ListaSolucao),

    % A mulher de 30 anos está usando uma presilha Verde.
    member(lutadora(verde,_,_,30,_,_), ListaSolucao),

    % A lutadora de Goiás está em algum lugar entre as lutadoras da região Sudeste e Norte, nessa ordem.
    entre(lutadora(_,_,_,_,goias,_), lutadora(_,_,_,_,espiritosanto,_), lutadora(_,_,_,_,tocantins,_), ListaSolucao),

    % Sônia está exatamente à esquerda da lutadora de presilha Amarela.
    aEsquerda(lutadora(_,sonia,_,_,_,_), lutadora(amarela,_,_,_,_,_), ListaSolucao),
    aoLado(lutadora(_,sonia,_,_,_,_), lutadora(amarela,_,_,_,_,_), ListaSolucao),

    % A Judoca está em algum lugar à direita da mulher de presilha Verde.
    aDireita(lutadora(_,_,judo,_,_,_), lutadora(verde,_,_,_,_,_), ListaSolucao),

    % A mulher que luta Jiu-jítsu tem 30 anos.
    member(lutadora(_,_,jiujitsu,30,_,_), ListaSolucao),

    % A lutadora da região Sul está ao lado da lutadora que gosta de Ler.
    aoLado(lutadora(_,_,_,_,parana,_), lutadora(_,_,_,_,_,ler), ListaSolucao),

    % Graziela está ao lado de quem gosta de Dançar.
    aoLado(lutadora(_,graziela,_,_,_,_), lutadora(_,_,_,_,_,dancar), ListaSolucao),

    % Quem gosta de Pintar está em uma das pontas.
    noCanto(lutadora(_,_,_,_,_,pintar), ListaSolucao),

    % A mulher que gosta de Dançar está ao lado da mulher que joga Capoeira.
    aoLado(lutadora(_,_,_,_,_,dancar), lutadora(_,_,capoeira,_,_,_), ListaSolucao),

    % A moça de 20 anos está em algum lugar à direita da lutadora de presilha Verde.
    aDireita(lutadora(_,_,_,20,_,_), lutadora(verde,_,_,_,_,_), ListaSolucao),

    % A lutadora da presilha Vermelha está em algum lugar à esquerda de quem pratica a luta que surgiu no Sudeste asiático.
    aEsquerda(lutadora(vermelha,_,_,_,_,_), lutadora(_,_,muaythai,_,_,_), ListaSolucao),

    % Quem gosta de Cozinhar está exatamente à esquerda de quem gosta de Ler.
    aEsquerda(lutadora(_,_,_,_,_,cozinhar), lutadora(_,_,_,_,_,ler), ListaSolucao),
    aoLado(lutadora(_,_,_,_,_,cozinhar), lutadora(_,_,_,_,_,ler), ListaSolucao),

    % A lutadora da região Centro-oeste está exatamente à esquerda da lutadora Tocantinense.
    aEsquerda(lutadora(_,_,_,_,goias,_), lutadora(_,_,_,_,tocantins,_), ListaSolucao),
    aoLado(lutadora(_,_,_,_,goias,_), lutadora(_,_,_,_,tocantins,_), ListaSolucao),

    % A mulher de presilha Branca está em algum lugar entre a Capixaba e a Andressa, nessa ordem.
    entre(lutadora(branca,_,_,_,_,_), lutadora(_,_,_,_,espiritosanto,_), lutadora(_,andressa,_,_,_,_), ListaSolucao),

    % Testa todas possibilidades.
    presilha(Presilha1),
    presilha(Presilha2),
    presilha(Presilha3),
    presilha(Presilha4),
    presilha(Presilha5),
    todosDiferentes([Presilha1,Presilha2,Presilha3,Presilha4,Presilha5]),

    nome(Nome1),
    nome(Nome2),
    nome(Nome3),
    nome(Nome4),
    nome(Nome5),
    todosDiferentes([Nome1,Nome2,Nome3,Nome4,Nome5]),

    luta(Luta1),
    luta(Luta2),
    luta(Luta3),
    luta(Luta4),
    luta(Luta5),
    todosDiferentes([Luta1,Luta2,Luta3,Luta4,Luta5]),

    idade(Idade1),
    idade(Idade2),
    idade(Idade3),
    idade(Idade4),
    idade(Idade5),
    todosDiferentes([Idade1,Idade2,Idade3,Idade4,Idade5]),

    estado(Estado1),
    estado(Estado2),
    estado(Estado3),
    estado(Estado4),
    estado(Estado5),
    todosDiferentes([Estado1,Estado2,Estado3,Estado4,Estado5]),

    hobby(Hobby1),
    hobby(Hobby2),
    hobby(Hobby3),
    hobby(Hobby4),
    hobby(Hobby5),
    todosDiferentes([Hobby1,Hobby2,Hobby3,Hobby4,Hobby5]).
