$(document).ready(function () {
    $('form').on('submit', function (e) {
        let email = $('input[name="email"]').val().trim();
        let password = $('input[name="password"]').val().trim();
        let isValid = true;

        if (!validateEmail(email)) {
            alert("Please enter a valid email.");
            isValid = false;
        } else if (password === '') {
            alert("Password is required.");
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault(); // prevent form submission
        }
    });

    function validateEmail(email) {
        let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }
});
