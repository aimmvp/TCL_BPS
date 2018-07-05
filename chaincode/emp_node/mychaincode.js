const shim = require('fabric-shim');
const util = require('util');

var Chaincode = class {
    Init(stub) {
        return Promise.resolve(shim.success());
    }

    Invoke(stub) {
        console.info('Transaction ID: ' + stub.getTxID());
        console.info(util.format('Args: %j', stub.getArgs()));

        let ret = stub.getFunctionAndParameters();
        console.info('Calling function: ' + ret.fcn);

        if(ret.fcn === "create"){
            return this.create(stub, ret.params);
        // }else if(ret.fcn === "update"){
        //     return update(stub, ret.params);
        }else if(ret.fcn === "getEmployee"){
            return this.getEmployee(stub, ret.params);
        }

        return Promise.reject(shim.error("Invalid invoke function name. Expecting \"invoke\" \"query\""));
    }

    create(stub, params) {
        console.info("execute Create.");

        let id = params[0];
        let name = params[1];
        let age = Number(params[2]);

        let values = Buffer.from(JSON.stringify({
            id : id,
            name : name,
            age : age
        }));

        console.log("create is success.")

        return stub.putState(id, values)
            .then(()=>{
                console.log("create success.");
                return shim.success();
            })
            .catch((err)=>{
                return shim.error(err);
            });
    }

    getEmployee(stub, params) {
        console.log("execute getEmployee.");

        let id = params[0];

        return stub.getState(id)
            .then((value)=>{
                return shim.success(Buffer.from(value.toString()));
            })
            .catch((err)=>{
                return shim.error(err);
            });
    }

};

shim.start(new Chaincode());