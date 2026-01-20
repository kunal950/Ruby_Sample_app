// Menu manipulation
// Add toggle listeners to listen for clicks.
document.addEventListener("turbo:load", function () {
  let account = document.querySelector("#account");
  account.addEventListener("click", function (event) {
    event.preventDefault();
    let menu = document.querySelector("#dropdown-menu");
    menu.classList.toggle("active");
  });
});
document.addEventListener("turbo:load", function () {
  const hamburger = document.querySelector("#hamburger");
  const menu = document.querySelector("#navbar-menu");

  if (hamburger && menu) {
    hamburger.addEventListener("click", function () {
      menu.classList.toggle("show");
    });
  }
});