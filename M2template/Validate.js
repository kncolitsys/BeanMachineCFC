/****************************************************************
FILE: RegExpValidate.js

DESCRIPTION: This file contains a library of validation functions
  using javascript regular expressions.  Library also contains 
  functions that reformat fields for display or for storage.


  VALIDATION FUNCTIONS:

  validateEmail - checks format of email address
    validateUSPhone - checks format of US phone number
    validateNumeric - checks for valid numeric value
  validateInteger - checks for valid integer value
    validateNotEmpty - checks for blank form field
  validateUSZip - checks for valid US zip code
  validateUSDate - checks for valid date in US format
  validateValue - checks a string against supplied pattern

  FORMAT FUNCTIONS:

  rightTrim - removes trailing spaces from a string
  leftTrim - removes leading spaces from a string
  trimAll - removes leading and trailing spaces from a string
  removeCurrency - removes currency formatting characters (), $
  addCurrency - inserts currency formatting characters
  removeCommas - removes comma separators from a number
  addCommas - adds comma separators to a number
  removeCharacters - removes characters from a string that match 
  passed pattern


AUTHOR: Karen Gayda

DATE: 03/24/2000
*******************************************************************/
function isRequired(Field) {
var len = Field.length	;
if (len == 0) {
return false;
} else {
return true;
}
} 


function validateButton(btn) {
    var cnt = -1;
    for (var i=btn.length-1; i > -1; i--) {
        if (btn[i].checked) {cnt = i; i = -1;}
    }
    if (cnt > -1) return btn[cnt].value;
    else return null;
}

function SingleSelectRequired(Field) {
var itemSelected =  Field.selectedIndex;
if (itemSelected == 0) {
return false;
} else {
return true;
}
} 

function validateEmail( strValue) {
/************************************************
DESCRIPTION: Validates that a string contains a
  valid email pattern.

 PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

REMARKS: Accounts for email with country appended
  does not validate that email contains valid URL
  type (.com, .gov, etc.) or valid country suffix.
*************************************************/
var objRegExp  =
 /(^[a-z]([a-z_\.]*)@([a-z_\.]*)([.][a-z]{3})$)|(^[a-z]([a-z_\.]*)@([a-z_\.]*)(\.[a-z]{3})(\.[a-z]{2})*$)/i;

  //check for valid email
  return objRegExp.test(strValue);
}

function validateIP( strValue ) {

  var objRegExp  =   /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;

  //check for valid us phone with or without space between
  //area code
  return objRegExp.test(strValue);
}
  
  
function validateUSPhone( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains valid
  US phone pattern.
  Ex. (999) 999-9999 or (999)999-9999
999-999-9999
PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
*************************************************/
//  var objRegExp  = /^\([1-9]\d{2}\)\s?\d{3}\-\d{4}$/;
  var objRegExp  =   /^\d{3}\-?\d{3}\-?\d{4}$/
  //check for valid us phone with or without space between
  //area code
  return objRegExp.test(strValue);
}

function  validateNumeric( strValue ) {
/*****************************************************************
DESCRIPTION: Validates that a string contains only valid numbers.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
******************************************************************/
  var objRegExp  =  /(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)/;

  //check for numeric characters
  return objRegExp.test(strValue);
}

function validateInteger( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only
    valid integer number.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
**************************************************/
  var objRegExp  = /(^-?\d\d*$)/;

  //check for integer characters
  return objRegExp.test(strValue);
}

function validateNotEmpty( strValue ) {
/************************************************
DESCRIPTION: Validates that a string is not all
  blank (whitespace) characters.

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.
*************************************************/
   var strTemp = strValue;
   strTemp = trimAll(strTemp);
   if(strTemp.length > 0){
     return true;
   }
   return false;
}

function validateUSZip( strValue ) {
/************************************************
DESCRIPTION: Validates that a string a United
  States zip code in 5 digit format or zip+4
  format. 99999 or 99999-9999

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

*************************************************/
var objRegExp  = /(^\d{5}$)|(^\d{5}-\d{4}$)/;

  //check for valid US Zipcode
  return objRegExp.test(strValue);
}


function validateCAZip( strValue ) {
/************************************************
DESCRIPTION: Validates that a string a United
  States zip code in 5 digit format or zip+4
  format. Z5Z-5Z5 orZ5Z5Z5

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

*************************************************/
var objRegExp  = /^\D{1}\d{1}\D{1}\-?\d{1}\D{1}\d{1}$/;

  //check for valid US Zipcode
  return objRegExp.test(strValue);
}


function validateUSDate( strValue ) {
/************************************************
DESCRIPTION: Validates that a string contains only
    valid dates with 2 digit month, 2 digit day,
    4 digit year. Date separator can be ., -, or /.
    Uses combination of regular expressions and
    string parsing to validate date.
    Ex. mm/dd/yyyy or mm-dd-yyyy or mm.dd.yyyy

PARAMETERS:
   strValue - String to be tested for validity

RETURNS:
   True if valid, otherwise false.

REMARKS:
   Avoids some of the limitations of the Date.parse()
   method such as the date separator character.
*************************************************/
  var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
 
  //check to see if in correct format
  if(!objRegExp.test(strValue))
    return false; //doesn't match pattern, bad date
  else{
    var strSeparator = strValue.substring(2,3) 
    var arrayDate = strValue.split(strSeparator); 
    //create a lookup for months not equal to Feb.
    var arrayLookup = { '01' : 31,'03' : 31, 
                        '04' : 30,'05' : 31,
                        '06' : 30,'07' : 31,
                        '08' : 31,'09' : 30,
                        '10' : 31,'11' : 30,'12' : 31}
    var intDay = parseInt(arrayDate[1],10); 

    //check if month value and day value agree
    if(arrayLookup[arrayDate[0]] != null) {
      if(intDay <= arrayLookup[arrayDate[0]] && intDay != 0)
        return true; //found in lookup table, good date
    }
    
    //check for February (bugfix 20050322)
    //bugfix  for parseInt kevin
    //bugfix  biss year  O.Jp Voutat
    var intMonth = parseInt(arrayDate[0],10);
    if (intMonth == 2) { 
       var intYear = parseInt(arrayDate[2]);
       if (intDay > 0 && intDay < 29) {
           return true;
       }
       else if (intDay == 29) {
         if ((intYear % 4 == 0) && (intYear % 100 != 0) || 
             (intYear % 400 == 0)) {
              // year div by 4 and ((not div by 100) or div by 400) ->ok
             return true;
         }   
       }
    }
  }  
  return false; //any other values, bad date
}

function validateValue( strValue, strMatchPattern ) {
/************************************************
DESCRIPTION: Validates that a string a matches
  a valid regular expression value.

PARAMETERS:
   strValue - String to be tested for validity
   strMatchPattern - String containing a valid
      regular expression match pattern.

RETURNS:
   True if valid, otherwise false.
*************************************************/
var objRegExp = new RegExp( strMatchPattern);

 //check if string matches pattern
 return objRegExp.test(strValue);
}


function rightTrim( strValue ) {
/************************************************
DESCRIPTION: Trims trailing whitespace chars.

PARAMETERS:
   strValue - String to be trimmed.

RETURNS:
   Source string with right whitespaces removed.
*************************************************/
var objRegExp = /^([\w\W]*)(\b\s*)$/;

      if(objRegExp.test(strValue)) {
       //remove trailing a whitespace characters
       strValue = strValue.replace(objRegExp, '$1');
    }
  return strValue;
}

function leftTrim( strValue ) {
/************************************************
DESCRIPTION: Trims leading whitespace chars.

PARAMETERS:
   strValue - String to be trimmed

RETURNS:
   Source string with left whitespaces removed.
*************************************************/
var objRegExp = /^(\s*)(\b[\w\W]*)$/;

      if(objRegExp.test(strValue)) {
       //remove leading a whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

function trimAll( strValue ) {
/************************************************
DESCRIPTION: Removes leading and trailing spaces.

PARAMETERS: Source string from which spaces will
  be removed;

RETURNS: Source string with whitespaces removed.
*************************************************/
 var objRegExp = /^(\s*)$/;

    //check for all spaces
    if(objRegExp.test(strValue)) {
       strValue = strValue.replace(objRegExp, '');
       if( strValue.length == 0)
          return strValue;
    }

   //check for leading & trailing spaces
   objRegExp = /^(\s*)([\W\w]*)(\b\s*$)/;
   if(objRegExp.test(strValue)) {
       //remove leading and trailing whitespace characters
       strValue = strValue.replace(objRegExp, '$2');
    }
  return strValue;
}

function removeCurrency( strValue ) {
/************************************************
DESCRIPTION: Removes currency formatting from
  source string.

PARAMETERS:
  strValue - Source string from which currency formatting
     will be removed;

RETURNS: Source string with commas removed.
*************************************************/
  var objRegExp = /\(/;
  var strMinus = '';

  //check if negative
  if(objRegExp.test(strValue)){
    strMinus = '-';
  }

  objRegExp = /\)|\(|[,]/g;
  strValue = strValue.replace(objRegExp,'');
  if(strValue.indexOf('$') >= 0){
    strValue = strValue.substring(1, strValue.length);
  }
  return strMinus + strValue;
}

function addCurrency( strValue ) {
/************************************************
DESCRIPTION: Formats a number as currency.

PARAMETERS:
  strValue - Source string to be formatted

REMARKS: Assumes number passed is a valid
  numeric value in the rounded to 2 decimal
  places.  If not, returns original value.
*************************************************/
  var objRegExp = /-?[0-9]+\.[0-9]{2}$/;

    if( objRegExp.test(strValue)) {
      objRegExp.compile('^-');
      strValue = addCommas(strValue);
      if (objRegExp.test(strValue)){
        strValue = '(' + strValue.replace(objRegExp,'') + ')';
      }
      return '$' + strValue;
    }
    else
      return strValue;
}

function removeCommas( strValue ) {
/************************************************
DESCRIPTION: Removes commas from source string.

PARAMETERS:
  strValue - Source string from which commas will
    be removed;

RETURNS: Source string with commas removed.
*************************************************/
  var objRegExp = /,/g; //search for commas globally

  //replace all matches with empty strings
  return strValue.replace(objRegExp,'');
}

function addCommas( strValue ) {
/************************************************
DESCRIPTION: Inserts commas into numeric string.

PARAMETERS:
  strValue - source string containing commas.

RETURNS: String modified with comma grouping if
  source was all numeric, otherwise source is
  returned.

REMARKS: Used with integers or numbers with
  2 or less decimal places.
*************************************************/
  var objRegExp  = new RegExp('(-?[0-9]+)([0-9]{3})');

    //check for match to search criteria
    while(objRegExp.test(strValue)) {
       //replace original string with first group match,
       //a comma, then second group match
       strValue = strValue.replace(objRegExp, '$1,$2');
    }
  return strValue;
}

function removeCharacters( strValue, strMatchPattern ) {
/************************************************
DESCRIPTION: Removes characters from a source string
  based upon matches of the supplied pattern.

PARAMETERS:
  strValue - source string containing number.

RETURNS: String modified with characters
  matching search pattern removed

USAGE:  strNoSpaces = removeCharacters( ' sfdf  dfd',
                                '\s*')
*************************************************/
 var objRegExp =  new RegExp( strMatchPattern, 'gi' );

 //replace passed pattern matches with blanks
  return strValue.replace(objRegExp,'');
}


/*
You can try it here. 
If you want to know more about these MSDN pages :
RegExp Object
Regular Expression Syntax 


Common expressions
Date
   /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/     mm/dd/yyyy
   
US zip code
  /(^\d{5}$)|(^\d{5}-\d{4}$)/             99999 or 99999-9999
  
Canadian postal code
  /^\D{1}\d{1}\D{1}\-?\d{1}\D{1}\d{1}$/   Z5Z-5Z5 orZ5Z5Z5
  
Time
  /^([1-9]|1[0-2]):[0-5]\d(:[0-5]\d(\.\d{1,3})?)?$/   HH:MM or HH:MM:SS or HH:MM:SS.mmm
  
IP Address(no check for alid values (0-255))
  /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/ 999.999.999.999
  
Dollar Amount
  /^((\$\d*)|(\$\d*\.\d{2})|(\d*)|(\d*\.\d{2}))$/ 100, 100.00, $100 or $100.00
  
Social Security Number
  /^\d{3}\-?\d{2}\-?\d{4}$/   999-99-9999 or999999999
  
Canadian Social Insurance Number
  /^\d{9}$/ 999999999

  NSA Password rules
  At least 1 lower-case letter. At least 1 Upper-case letter. At least 1 digit. At least 1 special character. Length should be between 8-30 characters. Spaces allowed
(?=^.{8,30}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+}{"":;'?/>.<,]).*$ 
*/


function mod10( cardNumber ) { // LUHN Formula for validation of credit card numbers.
	var ar = new Array( cardNumber.length );
	var i = 0,sum = 0;


    	for( i = 0; i < cardNumber.length; ++i ) {
    		ar[i] = parseInt(cardNumber.charAt(i));
    	}
    	for( i = ar.length -2; i >= 0; i-=2 ) { // you have to start from the right, and work back.
    		ar[i] *= 2;							 // every second digit starting with the right most (check digit)
    		if( ar[i] > 9 ) ar[i]-=9;			 // will be doubled, and summed with the skipped digits.
    	}										 // if the double digit is > 9, ADD those individual digits together 


        	for( i = 0; i < ar.length; ++i ) {
        		sum += ar[i];						 // if the sum is divisible by 10 mod10 succeeds
        	}
        	return (((sum%10)==0)?true:false);	 	
    }


        function expired( month, year ) {
        	var now = new Date();							// this function is designed to be Y2K compliant.
        	var expiresIn = new Date(year,month,0,0,0);		// create an expired on date object with valid thru expiration date
        	expiresIn.setMonth(expiresIn.getMonth()+1);		// adjust the month, to first day, hour, minute & second of expired month
        	if( now.getTime() < expiresIn.getTime() ) return false;
        	return true;									// then we get the miliseconds, and do a long integer comparison
    }


        function validateCreditCard(cardNumber,cardType,cardMonth,cardYear) {
        	if( cardNumber.length == 0 ) {						//most of these checks are self explanitory
        		alert("Please enter a valid card number.");
        		return false;				
        	}
        	for( var i = 0; i < cardNumber.length; ++i ) {		// make sure the number is all digits.. (by design)
        		var c = cardNumber.charAt(i);


            		if( c < '0' || c > '9' ) {
            			alert("Please enter a valid card number. Use only digits. do not use spaces or hyphens.");
            			return false;
            		}
            	}
            	var length = cardNumber.length;			//perform card specific length and prefix tests


                	switch( cardType ) {
                		case 'American Express':


                    			if( length != 15 ) {
                    				alert("Please enter a valid American Express Card number.");
                    				return false;
                    			}
                    			var prefix = parseInt( cardNumber.substring(0,2));


                        			if( prefix != 34 && prefix != 37 ) {
                        				alert("Please enter a valid American Express Card number.");
                        				return false;
                        			}
                        			break;
                        		case 'd':


                            			if( length != 16 ) {
                            				alert("Please enter a valid Discover Card number.");
                            				return false;
                            			}
                            			var prefix = parseInt( cardNumber.substring(0,4));


                                			if( prefix != 6011 ) {
                                				alert("Please enter a valid Discover Card number.");
                                				return false;
                                			}
                                			break;
                                		case 'Mastercard':


                                    			if( length != 16 ) {
                                    				alert("Please enter a valid MasterCard number.");
                                    				return false;
                                    			}
                                    			var prefix = parseInt( cardNumber.substring(0,2));


                                        			if( prefix < 51 || prefix > 55) {
                                        				alert("Please enter a valid MasterCard Card number.");
                                        				return false;
                                        			}
                                        			break;
                                        		case 'Visa':


                                            			if( length != 16 && length != 13 ) {
                                            				alert("Please enter a valid Visa Card number.");
                                            				return false;
                                            			}
                                            			var prefix = parseInt( cardNumber.substring(0,1));


                                                			if( prefix != 4 ) {
                                                				alert("Please enter a valid Visa Card number.");
                                                				return false;
                                                			}
                                                			break;
                                                	}
                                                	if( !mod10( cardNumber ) ) { 		// run the check digit algorithm
                                                		alert("Sorry! this is not a valid credit card number.");
                                                		return false;
                                                	}
                                                	if( expired( cardMonth, cardYear ) ) {							// check if entered date is already expired.
                                                		alert("Sorry! The expiration date you have entered would make this card invalid.");
                                                		return false;
                                                	}
                                                	
                                                	return true; // at this point card has not been proven to be invalid
                                            }

//is State a State in the US 
function validateState(State){

var i =0;
var States=new Array("AK","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","ID","IA","IL","IN","KS","KY","LA","MA","MD","ME","MI","MO","MN","MS","MT","NC","ND","NE","NH","NJ","NM","NY","NV","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY");
 for(i=0;i<=States.length;i++){
  if(State==States[i]){
    return true;
  }
 }
return false;
}


//is it a Province of canada 
function validateProvince(Province){

var i = 0;
var Provinces = new Array("AB","BC","MB","NU","NB","NL","NT","NS","ON","PE","QC","SK","YT")
 for(i=0;i<=Provinces.length;i++){
  if(Province==Provinces[i]){
    return true;
  }
 }
return false;
}

