;; Create types of agents: stations (sellers), drivers (buyers), cartel

breed [drivers driver]
breed [stations station]
breed [cartels cartel]

;; Create types of links possible: "deals" links a buyer with its choice of seller (resets every tick),
;; "known" links buyers with its known sellers a subset of the total sellers from wich he chooses,
;; "members" links cartel participants with the cartel agent

undirected-link-breed [deals deal]
undirected-link-breed [knowns known]
undirected-link-breed [members member]

;; Defining agent properties:

stations-own [fixed-costs desired-margin min-margin margin cartel-propension funds profit success price sales membership]
drivers-own [desired-travel income funds demand choice elasticity]
cartels-own [leader]

to setup

  clear-all

  ;; Create defined number of drivers with some random properties
  create-ordered-drivers num-drivers [
    set color white
    set desired-travel random 20000 + 10000
    fd 10
    set income random 4000 + 10000
    set elasticity random 25 + 10 ;; elasticity in economics means the effect of one variable in another, usually price or income. Statistically it is a parameter in an equation.
    ]

  ;; Create defined number of stations with some random properties
  create-ordered-stations num-stations [
    set color blue
    fd 15
    set desired-margin 5 * (random 20) + 15
    set min-margin 5 * random 3
    set margin 15
    set fixed-costs random 1000
    set success 1
    ]

  ;; Create the cartel agent, as the focal point of links between firms that choose to cartelize
  create-ordered-cartels 1 [
    set color green
    fd 5
    ]

  ;; Create network of drivers and their stations known

  ask drivers [
    repeat random num-stations + 1 [ create-known-with one-of stations ]
  ]

  reset-ticks

end


to go

  set-prices ;; Firms choose prices with a rule
  if cartel-possible = true [choose-cartel] ;; Stations choose to be part of the cartel
  drivers-buy ;; Drivers compare prices in their network and buy from chosen firm according to demand rule
  calculate-profits ;; Stations have profits based on their prices and demand total of their costumers


  ; some possible extensions:
    ; kill-debtors
    ; new-agents
    ; driver learning

  tick
  if ticks = 100 [stop]

end

to set-prices

  ;; If the station has a bigger profit than the last period (success) it will try to increase their margin until it reaches its margin goal
  ;; If not it will try to lower the margin to capture more market

  ask stations [

    ifelse success = 1 [ if margin < desired-margin [ set margin margin + 5 ]][ set margin margin - 5]
    if margin < min-margin [ set margin min-margin ]

    set price (1 + margin / 100) * wholesale-gas-price

  ]


end


to drivers-buy

  ask drivers [

    ask deals [die] ;; resets deals
    set choice min-one-of known-neighbors [ price ] ;; driver chooses best price from sellers he knows
    create-deal-with choice
    ifelse desired-travel - elasticity * [ price ] of choice < 0 [set demand 0] [set demand desired-travel - elasticity * [ price ] of choice] ;; demand function
    set funds income + funds - (demand * [ price ] of choice) ;; spends income

    ]


end

to calculate-profits

  ask stations [

    set sales sum [demand] of deal-neighbors ;; aggregates demand of all drivers that chose this particular station

    ifelse profit < (sales * price) - fixed-costs [set success 1] [set success 0] ;; checks for profit growth (important for price setting)
    set profit (sales * price) - fixed-costs - (sales * wholesale-gas-price) ;; calculates profit for period
    set funds funds + profit ;; adds profiut to existing funds

  ]

end

to choose-cartel

  ;; makes a random draw to see if firm joins or leaves cartel

  ask stations [

    if membership = 0 [ if random 10 < 1 [ set membership 1 create-members-with cartels ] ]
    if membership = 1 [ if random 10 < 1 [ set membership 0 ask my-members [die]  ] ]
    ask members [set color red]
  ]

;; designates station with higher margin the leader and uses that to set price of the others
;; as it is a later step it overrules the normal price setting decision

let empty max-one-of stations [membership]

if [membership] of empty = 1 [ ;; guarantees that there is always a leader so we don't get any errors here

  ask cartels [

     set leader max-one-of member-neighbors [margin]
     let leader-margin [margin] of leader
     ask member-neighbors with [membership = 1] [set price (1 + leader-margin / 100) * wholesale-gas-price]

  ] ]

end
