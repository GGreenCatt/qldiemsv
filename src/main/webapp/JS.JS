//===============Bật tắt Dropdown==================
document.addEventListener('DOMContentLoaded', function() {
    const dropdownTogglers = document.querySelectorAll('.dropdown-toggler');

    dropdownTogglers.forEach(function(toggler) {
      toggler.addEventListener('click', function() {
        dropdownTogglers.forEach(function(otherToggler) {
          if (otherToggler !== toggler) {
            otherToggler.classList.remove('open');
          }
        });

        toggler.classList.toggle('open');
      });
    });
  });
//================Tìm kiếm table=================
function myFunction() {
  // Declare variables
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
//==============Hiệu ứng Banner===================
let slideIndex = 0;
showSlides();
function showSlides() {
let i;
let slides = document.getElementsByClassName("mySlides");
let dots = document.getElementsByClassName("dot");
for (i = 0; i < slides.length; i++) {
  slides[i].style.display = "none";  
}
slideIndex++;
if (slideIndex > slides.length) {slideIndex = 1}    
for (i = 0; i < dots.length; i++) {
  dots[i].className = dots[i].className.replace(" dotactive", "");
}
slides[slideIndex-1].style.display = "block";  
dots[slideIndex-1].className += " dotactive";
setTimeout(showSlides, 3000);
}
//===========Phản hồi===============
function showAdditionalSelect() {
    var roleSelect = document.getElementById("roleSelect");
    var additionalSelect = document.getElementById("additionalSelect");

    if (roleSelect.value === "GV") {
      additionalSelect.style.display = "block";
    } else {
      additionalSelect.style.display = "none";
    }
  }