document.addEventListener("DOMContentLoaded", function () {
    const fragment = new DocumentFragment();
    const url = "http://localhost:4567/tests";
    const tableHeader = document.getElementById("tests-table-header");
    const tableBody = document.getElementById("tests-table-body");
    const noDataMessage = document.getElementById("no-data-message");

    fetch(url)
        .then(response => response.json())
        .then(data => {
            if (data.length === 0) {
                noDataMessage.style.display = "block";
            } else {
                noDataMessage.style.display = "none";
                const headerRow = document.createElement("tr");
                const headers = ["Token", "Data", "CPF", "Nome", "Médico", "CRM"];
                headers.forEach(header => {
                    const th = document.createElement("th");
                    th.textContent = header;
                    headerRow.appendChild(th);
                });
                tableHeader.appendChild(headerRow);
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
            }
        });

    document.getElementById("search-form").addEventListener("submit", function (event) {
        event.preventDefault();
        const token = document.getElementById("token-input").value;
        fetch(`${url}/${token}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Exame não encontrado");
                }
                return response.json();
            })
            .then(data => {
                const resultDiv = document.getElementById("search-result");
                resultDiv.innerHTML = `
                    <div class="card card-custom">
                        <div class="card-header text-center">
                            <h2>Detalhes do Exame</h2>
                        </div>
                        <div class="card-body">
                            <p><strong>Token:</strong> ${data.result_token}</p>
                            <p><strong>Data:</strong> ${data.result_date}</p>
                            <p><strong>CPF:</strong> ${data.cpf}</p>
                            <p><strong>Nome:</strong> ${data.name}</p>
                            <p><strong>Email:</strong> ${data.email}</p>
                            <p><strong>Aniversário:</strong> ${data.birthday}</p>
                            <p><strong>Médico:</strong> ${data.doctor.name}</p>
                            <p><strong>CRM:</strong> ${data.doctor.crm}</p>
                            <p><strong>Estado CRM:</strong> ${data.doctor.crm_state}</p>
                            <h3>Resultados</h3>
                            <ul>
                                ${data.tests.map(test => `<li>${test.type}: ${test.result} (${test.limits})</li>`).join('')}
                            </ul>
                        </div>
                        <div class="card-footer text-center">
                            <a href="/" class="btn btn-secondary">Voltar à Lista</a>
                        </div>
                    </div>
                `;
                resultDiv.style.display = "block";
                document.getElementById("tests-table").style.display = "none";
            })
            .catch(error => {
                const resultDiv = document.getElementById("search-result");
                resultDiv.innerHTML = `
                    <div class="alert alert-danger" role="alert">
                        Exame não encontrado. Verifique o token e tente novamente.
                    </div>
                `;
                resultDiv.style.display = "block";
            });
    });
});