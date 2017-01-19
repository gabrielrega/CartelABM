# Abstract
(objetivo de contruir um modelo de mercado para análise de cartéis, importancia da defesa da concorrencia, usamos hash and beans como base.)

# Gasoline Markets in Economic Literature
(vancouver price wars, outros da TESE)

# Facts on oligopolised markets
(da teses tbm, parte mais teórica)
(descrição dos fatos estilizados)

# Model Description

(picture)
(interactive version of the model has to be online)

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

After this structure is defined we start to set up the initial conditions of a model run. First we create the drivers (consumers). In the interactive version of the model, this number is user-defined. For each driver, it is assigned, semi-randomly, some of the attributes describe above, namely, their desired travel, elasticity of demand and their income. The randomness allows us to create diffentiated agents, which is a central feature of agent based models. The elasticity parameter is a strong candidate for further studies, as it can be thought of as related to the product characteristics and can be easily changed for use in other contexts.
The same procedure is applied for the creation of the stations. The number is again user-defined in the interactive version o the model

## Market Description (as Tesfatsion below)

### Each period of the timeline
### Tesfatsion Model Structure

Model name
* a.1. economy in the initial period: description of the "economy" The ACE Trading World is a discrete-time dynamic economy that runs during periods T = 0, 1, . . . , TMax. The economy produces two perishable infinitely-divisible goods, hash and beans.
* a.2. activity flow for hash firms (a breed) in period T with equations
* a.3. profit alocation for firm j, equations
* a.4 learning for firms and investment equations
* a.5. activity flow for beans firms (other breed)
* a.6. activity flow for consumers
* a.7. consumer price discovery

# Experiments

Effects on prices and profits, consumer surplus?
(change number of firms)
(cartel on/off)

# Validation

(are these results realistics, comparing with the stylised facts?)

# Further Research

(alternative price rule, consumer learning - high price out, random one in, seller networks (more than one cartel and network mergers), generalized market (how to? change elasticity, more than one supplier, add industry, seller networks, price promotions)
