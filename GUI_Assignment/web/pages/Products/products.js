const toggleBtn = document.querySelector('#toggleBtn');
const divList = document.querySelector('.categories-filtering');

toggleBtn.addEventListener('click', () => {
    if(divList.style.display == "none"){    
        divList.style.display = "block";
        toggleBtn.innerHTML = 'Hide Filters <i class="fa fa-filter"></i>';
    }else{
        divList.style.display = "none";
        toggleBtn.innerHTML = 'Show Filters <i class="fa fa-filter"></i>';
    }
});

