/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let list = document.querySelectorAll(".navigation li");

function activeLink() {
  list.forEach((item) => {
    item.classList.remove("hovered");
  });
  this.classList.add("hovered");
}

list.forEach((item) => item.addEventListener("mouseover", activeLink));

// Menu Toggle
let toggle = document.querySelector(".toggle");
let navigation = document.querySelector(".navigation");
let main = document.querySelector(".main");

toggle.onclick = function () {
  navigation.classList.toggle("active");
  main.classList.toggle("active");
};

// Thêm script này vào HTML
document.querySelectorAll('.navigation ul li a').forEach(item => {
  item.addEventListener('click', function(e) {
    // Remove active from all items
    document.querySelectorAll('.navigation ul li').forEach(li => {
      li.classList.remove('active', 'wave-animation', 'pulse-animation');
    });
    
    // Add effects to clicked item
    const parentLi = this.parentElement;
    parentLi.classList.add('active', 'wave-animation', 'pulse-animation');
    
    // Remove wave animation after completion
    setTimeout(() => {
      parentLi.classList.remove('wave-animation', 'pulse-animation');
    }, 500);
  });
});

// Toggle navigation
document.querySelector('.toggle').addEventListener('click', function() {
  document.querySelector('.navigation').classList.toggle('active');
  document.querySelector('.main').classList.toggle('active');
  this.classList.add('ripple');
  
  setTimeout(() => {
    this.classList.remove('ripple');
  }, 600);
});

