function CheckWallet(type, string) {

    let regex = '';

    if (type === 'btc'){
        let regex = '/^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$/';
    } else if(type === 'eth'){
        let regex = '/^0x[a-fA-F0-9]{40}$/';
    } else if(type === 'ltc'){
        let regex = '/^[LM3][a-km-zA-HJ-NP-Z1-9]{26,33}$/';
    } else{
        let regex = '/^r[rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz]{27,35}$/';
    }

    return regex.text(string);

}