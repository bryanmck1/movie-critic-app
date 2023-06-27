// Hamburger icon in Navbar
document.addEventListener("turbo:load", function () {
  const hamburgerMenu = document.querySelector(".hamburger-menu");
  const navbarMenu = document.querySelector(".navbar-menu");

  hamburgerMenu.addEventListener("click", function () {
    navbarMenu.classList.toggle("hidden");
  });
});

// Profile expansion pop up box in Navbar
document.addEventListener("turbo:load", function () {
  const profileMenu = document.querySelector("#account-menu");
  const profile = document.querySelector(".profile");

  profileMenu.addEventListener("click", function () {
    profile.classList.toggle("hidden");
  });
});

// Listen's for change in checkboxes
document.addEventListener("turbo:load", function () {
  const checkboxes = document.querySelectorAll(
    '#filter-form input[type="checkbox"]'
  );

  checkboxes.forEach(function (checkbox) {
    checkbox.addEventListener("change", function () {
      document.getElementById("filter-form").requestSubmit();
    });
  });
});

// Submits form after a user starts typing
function submitForm(event) {
  clearTimeout(window.formSubmitTimeout);

  window.formSubmitTimeout = setTimeout(() => {
    event.target.form.requestSubmit();
  }, 200);
}

// Adds active colors to buttons on sign up/ log in
document.addEventListener("turbo:load", function () {
  const currentUrl = window.location.href;

  if (
    currentUrl === "http://localhost:3000/" ||
    currentUrl === "http://localhost:3000/users/sign_in"
  ) {
    console.log("YES");
    const loginBtn = document.getElementById("loginBtn");
    loginBtn.classList.toggle("bg-blue-500");
    loginBtn.classList.remove("bg-white");
  } else if (currentUrl === "http://localhost:3000/users/sign_up") {
    const signUpBtn = document.getElementById("signupBtn");
    signUpBtn.classList.toggle("bg-blue-500");
    signUpBtn.classList.toggle("bg-white");
  }
});

// Resets forms in search review page
function resetForms() {
  const checkboxesForm = document.getElementById("filter-form");
  checkboxesForm.reset();
  const searchForm = document.getElementById("search-input");
  searchForm.reset();
}

// Toggles content on review movie page
document.addEventListener("turbo:load", function () {
  const toggleBtn = document.querySelector("#toggle-btn");
  const movieDetails = document.querySelector("#movie-details");

  toggleBtn.addEventListener("click", function () {
    movieDetails.classList.toggle("hidden");
    toggleBtn.classList.toggle("rotate-180");
  });
});

// Shows delete modal on index page
document.addEventListener("turbo:load", function () {
  const deleteBtns = document.querySelectorAll(".review-delete");

  deleteBtns.forEach(function (deleteBtn) {
    deleteBtn.addEventListener("click", function () {
      const reviewId = deleteBtn.dataset.reviewId;
      const modal = document.querySelector(`#modal-${reviewId}`);
      modal.classList.toggle("hidden");
    });
  });
});
