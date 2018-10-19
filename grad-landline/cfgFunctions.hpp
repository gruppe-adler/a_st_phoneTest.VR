class GRAD_landline {

    class client_actions {
        file = grad-landline\functions\client\actions;

        class addAction;
    };

    class client_calls {
        file = grad-landline\functions\client\calls;

        class callPluginActivate;
        class callPluginDeactivate;
        class callStart;

    };

    class client_sounds {
        file = grad-landline\functions\client\sounds;

        class soundHangUp;
        class soundHookIn;
    };

    class client_far {
        file = grad-landline\functions\client\tfar;

      class setTFARfakeRadio;
    }




    class server_calls {
       file = grad-landline\functions\server\calls;

       class callRegister;
       class callUnregister;
    };

    class server_core {
       file = grad-landline\functions\server\core;

       class addPhone;
       class distributePhones;
       class initServer { preInit = 1; };
    };

    class server_number {
       file = grad-landline\functions\server\number;

       class extractNumberFromPrefix;
       class generateBaseNumber;
    };
    
};