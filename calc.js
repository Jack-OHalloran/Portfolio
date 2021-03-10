function doSomething()
{

    if (document.getElementById('subtract').checked & document.getElementById('add').checked) {
        alert("Only select one Math Method at a time")
    }

    else if (document.getElementById('add').checked) {
        let first = document.querySelector('#first').value;
        let second = document.querySelector('#second').value;
        let sum = parseInt(first) + parseInt(second);
        let outp = document.querySelector("#output");
        outp.innerHTML = sum;
    }
    else if (document.getElementById('subtract').checked) {
        let first = document.querySelector('#first').value;
        let second = document.querySelector('#second').value;
        let sum = parseInt(first) - parseInt(second);
        let outp = document.querySelector("#output");
        outp.innerHTML = sum;

    }
    else {
        alert("Choose Math Method")
        return false;
    }
}


let btn = document.querySelector('#ok');
btn.addEventListener('click',doSomething);