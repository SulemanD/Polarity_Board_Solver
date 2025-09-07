Class {
	#name : #PolarityLog,
	#superclass : #Object,
	#instVars : [
		'res_1',
		'res_2a',
		'res_2b',
		'res_3a',
		'res_3b',
		'res_4a',
		'res_4b',
		'res_5'
	],
	#category : #CPS506
}

{ #category : #'as yet unclassified' }
PolarityLog >> getAll [
	| nl |
	nl := String with: Character cr.
	^ self get_1, nl, self get_2a, nl, self get_2b, nl, self get_3a, nl, self get_3b, nl, 
		self get_4a, nl, self get_4b, nl, self get_5
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_1 [
	^res_1
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_2a [
	^res_2a
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_2b [
	^res_2b
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_3a [
	^res_3a
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_3b [
	^res_3b
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_4a [
	^res_4a
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_4b [
	^res_4b
]

{ #category : #'as yet unclassified' }
PolarityLog >> get_5 [
	^res_5
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_1: result [
	res_1 := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_2a: result [
	res_2a := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_2b: result [
	res_2b := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_3a: result [
	res_3a := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_3b: result [
	res_3b := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_4a: result [
	res_4a := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_4b: result [
	res_4b := result
]

{ #category : #'as yet unclassified' }
PolarityLog >> set_5: result [
	res_5 := result
]
