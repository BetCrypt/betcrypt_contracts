// These actually aren't being used anywhere, but probably useful in the frontend
// to format title and options to be sent to smart contract

/**
 * Takes in arbitrary length string and returns an array of 32 character slices,
 * last index is string.length % 32
 */
function splitLongString(string) {
	var ret_list = [];
    
    for (i = 0; i < Math.floor(string.length / 32); i++)
    {
        ret_list.push(string.substr((32 * i), 32));
    }
    if(string.length % 32)
        ret_list.push(string.substr(string.length - string.length % 32));
        
    return ret_list;
}
