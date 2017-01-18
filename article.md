LEMBRETE: texto em inglês
Usar tópicos no estilo dos artigos do Andrea (existe um artigo recente), essencialmente, limitando o problema e tentando comparar fatos estilizados que o modelo e capaz de reproduzir.
# Tarefa Inicial:
descrever o modelo, conforme as partes do arquivo netlogo. O artigo do Testfatsion no Handobook é um bom exemplo de descrição de modelos que posso utilizar.

# Model Description

(picture)

## Pre-Setup

We start by defining three kinds of agents: the consumer (*driver*), the seller (*station*) and the cartel. We follow by defining the possible relations among these agents (the *links* in NetLogo lingo): *membership* of cartel between the sellers and the cartel structure, *knowledge* between consumers and firms, which defines the consumer price search breadth, that is, from wich firms the consumer gets price information and chooses from when buying and *deals* that link consumers with their chosen seller for that period.

```
breed [drivers driver]
breed [stations station]
breed [cartels cartel]
undirected-link-breed [deals deal]
undirected-link-breed [knowns known]
undirected-link-breed [members member]
```

Next we choose the characteristics of each type of agent (*breeds*). Stations have fixed costs (operating costs that will be incurred each period not related to the number of sales), a desired margin of profit (what is the markup over the wholesale price that the seller feels comfortable and is trying to reach), a minimum margin of profit (a lower limit to the markup the company chooses, can represent a behavioral pattern, for example, that a particular seller never takes part in a price war), an actual profit margin (to be used in the current period), a cartel propension statistic (how likely it is that this particular seller would join a cartel), funds (total amount of money in current possession, being modified by profits and costs), profit (income less costs), price (equal to marginal cost plus margin), sales (sum of the quantity of product desired from all customers that have chosen this firm as a *deal* partner at this time) and membership (a yes/no value that represents if this seller is part of a cartel).
Drivers are defined by a desired travel statistic and a elasticity of consumption, the two of which will form later this individual's demand curve. They also have an exogenous income source and a stock of funds, limiting how much they can buy, a demand (how much they chose to consume in a period, resulting from their demand curve and the prices they face) and a choice, representing which seller they chose to buy from at a point in time. Cartels only have one attribute: which seller is the leader, from which the members will *copy* their decisions.

```
stations-own [fixed-costs desired-margin min-margin margin cartel-propension funds profit success price sales membership]
drivers-own [desired-travel income funds demand choice elasticity]
cartels-own [leader]
```

## Setup



