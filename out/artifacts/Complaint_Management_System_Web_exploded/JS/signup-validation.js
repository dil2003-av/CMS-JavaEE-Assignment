$(document).ready(function () {
    $('form').on('submit', function (e) {
        let isValid = true;

        let username = $('input[name="username"]').val().trim();
        let password = $('input[name="password"]').val().trim();
        let email = $('input[name="email"]').val().trim();
        let role = $('select[name="role"]').val();

        if (username === '') {
            alert("Username is required.");
            isValid = false;
        } else if (password.length < 6) {
            alert("Password must be at least 6 characters.");
            isValid = false;
        } else if (!validateEmail(email)) {
            alert("Please enter a valid email.");
            isValid = false;
        } else if (!role) {
            alert("Please select a role.");
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault(); // form eka submit wenne na
        }
    });

    function validateEmail(email) {
        let regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }
});
