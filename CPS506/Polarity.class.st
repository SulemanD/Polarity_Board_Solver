Class {
	#name : #Polarity,
	#superclass : #Object,
	#category : #CPS506
}

{ #category : #testing }
Polarity class >> canPlace: result on: board row:i column: j type: type [

|pos notType |

    type == $+   ifTrue: [ notType := $- ].
    type == $- ifTrue: [ notType := $+ ].

pos :=((board at: i) at: j).
pos == $L ifTrue: [ (self validplacement: result row: i column: j+1 type: (notType)) ifTrue: [^true]].
pos == $R ifTrue: [ (self validplacement: result row: i column: j-1 type: (notType))ifTrue: [^true]].			
pos == $T ifTrue: [ (self validplacement: result row: i+1 column: j type: (notType))ifTrue: [^true]].
pos == $B ifTrue: [ (self validplacement: result row: i-1 column: j type: (notType))ifTrue: [^true]].

^false 
]

{ #category : #'as yet unclassified' }
Polarity class >> place: type on: result with: pos at: i and: j [
    | notType updatedRow updatedOtherRow |

    type == $+   ifTrue: [ notType := $- ].
    type == $- ifTrue: [ notType := $+ ].

    updatedRow := result at: i.

    pos == $L ifTrue: [
        updatedRow := updatedRow copyReplaceFrom: j to: j with: (type asString).
        updatedRow := updatedRow copyReplaceFrom: (j + 1) to: (j + 1) with: notType asString .
        result at: i put: updatedRow.
    ].

    pos == $R ifTrue: [
        updatedRow := updatedRow copyReplaceFrom: j to: j with: type asString.
        updatedRow := updatedRow copyReplaceFrom: (j - 1) to: (j - 1) with: notType asString.
        result at: i put: updatedRow.
    ].

    pos == $T ifTrue: [
        updatedOtherRow := result at: (i + 1).
        updatedRow := updatedRow copyReplaceFrom: j to: j with: type asString.
        updatedOtherRow := updatedOtherRow copyReplaceFrom: j to: j with: notType asString.
        result at: i put: updatedRow.
        result at: (i + 1) put: updatedOtherRow.
    ].

    pos == $B ifTrue: [
        updatedOtherRow := result at: (i - 1).
        updatedRow := updatedRow copyReplaceFrom: j to: j with: type asString.
        updatedOtherRow := updatedOtherRow copyReplaceFrom: j to: j with: notType asString.
        result at: i put: updatedRow.
        result at: (i - 1) put: updatedOtherRow.
    ].

    ^result
]

{ #category : #'as yet unclassified' }
Polarity class >> solve: board with: specs [

|height width result mspecs traversalOrder history undo|

	" 	The solution to board 1 is hard-coded below, just to demonstrate 
 	  	what the return format should look like. It will pass the first
	  	test like this, but you may NOT leave it like this. Hardcoding is
		not allowed.  "
		
"Use this to get dimensions of the board"
height:= board size.
width:= (board at: 1) size.

"Intialize history for backtracking and order for solving board"
history := OrderedCollection new.
traversalOrder := OrderedCollection new.

"create a modifiable specs, will one part of board state"
mspecs := Dictionary new.
specs keysAndValuesDo: [:key :val |
	| newArray |
	newArray := Array new: val size.
   1 to: val size do: [:i | newArray at: i put: (val at: i) ].
	mspecs at: key put: newArray.
    ].

specs keysAndValuesDo: [:key :val | 
	|i|
	i := 1.
	val do: [:each |
		traversalOrder add: (Array with: each with: (Array with: key with: i)). 
		i:= i+ 1.
		 ]
	].

traversalOrder := traversalOrder asSortedCollection: [:a :b |	
	(a first = b first )
		ifTrue: [ a second first < b second first]
		ifFalse: [ a first > b first ].
	]. 


"Intialize the result"
result:= Array new: height.
1 to: height do: [:i | result at: i put: (String new: width withAll: $X) ].

undo:= [ 
	history last. 
	
	].



"Interate over the results board focused on rows polarity first"
1 to: result size do: [:i |
	|row |
	row:= result at: i.
	1 to: row size do: [:j |
		|colm leftVal topVal|
		colm:= row at: j.
		
		 
leftVal := mspecs at: #left at: i.
topVal := mspecs at: #top at: j.
		
		"Check if polarity's are still greater than zero if so keep adding pieces"
		((mspecs at: #left at: i) = 0) not & ((mspecs at: #top at: j) = 0) not & (((result at: i) at: j) == $X) & (((mspecs at: #left at: i) > 0) | ((mspecs at: #top at: j) > 0)) ifTrue: [
			( self validplacement: result row: i column: j type: $+) & (self canPlace: result on: board row: i column: j type: $+) ifTrue: [ 
				(self withinbounds: mspecs at: i and: j with: $+ and: ((board at: i) at: j)) ifTrue: [
					 mspecs:= (self updateSpecs: mspecs at: i and: j given: ((board at: i) at: j) andType: $+).
					result := self place: $+ on: result with: ((board at: i) at: j) at: i and: j.

				].
				]. 
			].
		].
	]. 

"Interate over the results board again, this time for coulumns polarity"
1 to: result size do: [:i |
	|row |
	row:= result at: i.
	1 to: row size do: [:j |
		|colm|
		colm:= row at: j.
		
		"Check if polarity's are still greater than zero if so keep adding pieces"
		((mspecs at: #right at: i) = 0) not & ((mspecs at: #bottom at: j) = 0) not & (((result at: i) at: j) == $X) & (((mspecs at: #bottom at: j) > 0) | ((mspecs at: #right at: i) > 0)) ifTrue: [
			( self validplacement: result row: i column: j type: $-) & (self canPlace: result on: board row: i column: j type: $-) ifTrue: [
				(self withinbounds: mspecs at: i and: j with: $- and: ((board at: i) at: j)) ifTrue: [ 					
					mspecs:= (self updateSpecs: mspecs at: i and: j given: ((board at: i) at: j) andType: $-).
					result := self place: $- on: result with: ((board at: i) at: j) at: i and: j.

				
					].
				]. 
			].
		].
	]. 




	
 ^result
	
]

{ #category : #'editing keys' }
Polarity class >> undo: history [

history 
]

{ #category : #'as yet unclassified' }
Polarity class >> updateSpecs: mspecs at: i and: j given: pos andType: type [

type == $+ ifTrue:[
	
	pos == $L ifTrue: [		
		mspecs at: #left at: i put: ((mspecs at: #left at: i)-1).
		mspecs at: #top at: j put: ((mspecs at: #top at: j)-1).
		mspecs at: #right at: i put: ((mspecs at: #right at: i)-1).
		mspecs at: #bottom at: j+1 put: ((mspecs at: #bottom at: j+1)-1).
		^mspecs
	].

	pos == $R ifTrue: [ 
		mspecs at: #left at: i put: ((mspecs at: #left at: i)-1).
		mspecs at: #top at: j put: ((mspecs at: #top at: j)-1).
		mspecs at: #right at: i put: ((mspecs at: #right at: i)-1).
		mspecs at: #bottom at: j-1 put: ((mspecs at: #bottom at: j-1)-1).
		^mspecs
	].

	pos == $T ifTrue: [ 
		mspecs at: #left at: i put: ((mspecs at: #left at: i)-1).
		mspecs at: #top at: j put: ((mspecs at: #top at: j)-1).
		mspecs at: #right at: i+1 put: ((mspecs at: #right at: i+1)-1).
		mspecs at: #bottom at: j put: ((mspecs at: #bottom at: j)-1).
		^mspecs
	].

	pos == $B ifTrue: [ 
		mspecs at: #left at: i put: ((mspecs at: #left at: i)-1).
		mspecs at: #top at: j put: ((mspecs at: #top at: j)-1).
		mspecs at: #right at: i-1 put: ((mspecs at: #right at: i-1)-1).
		mspecs at: #bottom at: j put: ((mspecs at: #bottom at: j)-1).
		^mspecs
	].

].

type == $- ifTrue: [
	
	pos == $L ifTrue: [		
		mspecs at: #left at: i put: ((mspecs at: #left at: i)-1).
		mspecs at: #top at: j+1 put: ((mspecs at: #top at: j+1)-1).
		mspecs at: #right at: i put: ((mspecs at: #right at: i)-1).
		mspecs at: #bottom at: j put: ((mspecs at: #bottom at: j)-1).
		^mspecs
	].

	pos == $R ifTrue: [ 
		mspecs at: #left at: i put: ((mspecs at: #left at: i)-1).
		mspecs at: #top at: j-1 put: ((mspecs at: #top at: j-1)-1).
		mspecs at: #right at: i put: ((mspecs at: #right at: i)-1).
		mspecs at: #bottom at: j put: ((mspecs at: #bottom at: j)-1).
		^mspecs
	].

	pos == $T ifTrue: [ 
		mspecs at: #left at: i+1 put: ((mspecs at: #left at: i+1)-1).
		mspecs at: #top at: j put: ((mspecs at: #top at: j)-1).
		mspecs  at: #right at: i put: ((mspecs at: #right at: i)-1).
		mspecs at: #bottom at: j put: ((mspecs at: #bottom at: j)-1).
		^mspecs
	].

	pos == $B ifTrue: [ 
		mspecs at: #left at: i-1 put: ((mspecs at: #left at: i-1)-1).
		mspecs at: #top at: j put: ((mspecs at: #top at: j)-1).
		mspecs at: #right at: i put: ((mspecs at: #right at: i)-1).
		mspecs at: #bottom at: j put: ((mspecs at: #bottom at: j)-1).
		^mspecs
	].

].

^mspecs
]

{ #category : #'as yet unclassified' }
Polarity class >> validplacement: result row: i column: j type: type [

|leftb rightb topb bottomb|
leftb:= topb := 1.

rightb:= (result at: 1) size.

bottomb := result size.

((result at: i) at: j) == $X ifFalse: [ ^false].


(i-1) >= topb ifTrue: [((result at: i-1) at: j)== type ifTrue: [^false]].

(i+1) <= bottomb ifTrue: [((result at: i+1)at: j) == type ifTrue: [^false]].

(j-1) >= leftb ifTrue: [((result at: i) at:j-1) == type ifTrue: [^false]].

(j+1) <= rightb ifTrue: [((result at: i) at:j+1) == type ifTrue: [^false]].

^true.
]

{ #category : #'as yet unclassified' }
Polarity class >> withinbounds: mspecs at: i and: j with: type and: pos [

|notType|
type == $+   ifTrue: [ notType := $- ].
type == $- ifTrue: [ notType := $+ ].

pos == $L ifTrue: [ 
notType == $+ ifTrue: [((mspecs at: #left at: i) ~= 0) & ((mspecs at: #top at: j+1) ~= 0) ifTrue: [^true] ifFalse:[^false]].
notType == $- ifTrue: [((mspecs at: #right at: i) ~= 0) & ((mspecs at: #bottom at: j+1) ~= 0) ifTrue: [^true] ifFalse:[^false]].
].

pos == $R ifTrue: [ 
notType == $+ ifTrue: [((mspecs at: #left at: i) ~= 0) & ((mspecs at: #top at: j-1) ~= 0) ifTrue: [^true] ifFalse:[^false]].
notType == $- ifTrue: [((mspecs at: #right at: i) ~= 0) & ((mspecs at: #bottom at: j-1) ~= 0) ifTrue: [^true] ifFalse:[^false]].
].

pos == $T ifTrue: [ 
notType == $+ ifTrue: [((mspecs at: #left at: i+1) ~= 0) & ((mspecs at: #top at: j) ~= 0) ifTrue: [^true] ifFalse:[^false]].
notType == $- ifTrue: [((mspecs at: #right at: i+1) ~= 0) & ((mspecs at: #bottom at: j) ~= 0) ifTrue: [^true] ifFalse:[^false]].
].

pos == $B ifTrue: [ 
notType == $+ ifTrue: [((mspecs at: #left at: i-1) ~= 0) & ((mspecs at: #top at: j) ~= 0) ifTrue: [^true] ifFalse:[^false]].
notType == $- ifTrue: [((mspecs at: #right at: i-1) ~= 0) & ((mspecs at: #bottom at: j) ~= 0) ifTrue: [^true] ifFalse:[^false]].
].

^false.

]
