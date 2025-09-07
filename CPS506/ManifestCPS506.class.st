"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCPS506,
	#superclass : #PackageManifest,
	#category : #'CPS506-Manifest'
}

{ #category : #'code-critics' }
ManifestCPS506 class >> ruleStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'Polarity class' #solve:with: #true)) #'2025-08-24T08:54:32.893-04:00') #(#(#RGMetaclassDefinition #(#'Polarity class' #Polarity)) #'2025-08-24T08:54:43.241-04:00') )
]

{ #category : #'code-critics' }
ManifestCPS506 class >> ruleToDoCollectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'Polarity class' #solve:with: #true)) #'2025-08-20T07:01:57.901-04:00') )
]

{ #category : #'code-critics' }
ManifestCPS506 class >> ruleToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'Polarity class' #solve:with: #true)) #'2025-08-20T07:02:09.755-04:00') )
]
