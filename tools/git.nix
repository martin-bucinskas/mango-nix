{ ... }: {
    programs.git = {
        enable = true;
        userName = "martin-bucinskas";
        userEmail = "martin@martinb.dev";
        signing.key = "5A65D2BB900A3DB5";
        signing.signByDefault = true;
    };
}