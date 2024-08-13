document.addEventListener("DOMContentLoaded", function () {
    const fragment = new DocumentFragment();
    const url = "http://localhost:4567/tests";

    fetch(url)
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById("tests-table-body");
            data.forEach(test => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${test.result_token}</td>
                    <td>${test.result_date}</td>
                    <td>${test.cpf}</td>
                    <td>${test.name}</td>
                    <td>${test.doctor.name}</td>
                    <td>${test.doctor.crm}</td>
                `;
                fragment.appendChild(row);
            });
            tableBody.appendChild(fragment);
        });

    document.getElementById("search-form").addEventListener("submit", function (event) {
        event.preventDefault();
        const token = document.getElementById("token-input").value;
        fetch(`${url}/${token}`)
            .then(response => response.json())
            .then(data => {
                document.getElementById("detail-token").textContent = data.result_token;
                document.getElementById("detail-date").textContent = data.result_date;
                document.getElementById("detail-cpf").textContent = data.cpf;
                document.getElementById("detail-name").textContent = data.name;
                document.getElementById("detail-email").textContent = data.email;
                document.getElementById("detail-birthday").textContent = data.birthday;
                document.getElementById("detail-doctor-name").textContent = data.doctor.name;
                document.getElementById("detail-crm").textContent = data.doctor.crm;
                document.getElementById("detail-crm-state").textContent = data.doctor.crm_state;

                const testsList = data.tests.map(test => `<li>${test.type}: ${test.result} (${test.limits})</li>`).join('');
                document.getElementById("detail-tests").innerHTML = testsList;

                document.getElementById("search-result").style.display = "block";
                document.getElementById("tests-table").style.display = "none";
            })
            .catch(error => console.error("Erro ao buscar o exame:", error));
    });
});
