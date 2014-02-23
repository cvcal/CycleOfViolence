
//    Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.define("makeTargetCycle", function(request, response) {
  request.params.query.find({
    success: function(results) {
      var len = results.length;
      var lastUser = results[len-1];
      for (var i=0; i <= len-1; i++) {
        //results[i].set("target", lastUser);
        results[i].set("cloudTest", "success!");
        lastUser = results[i];
      }
      response.success();
    }, error: function() {
      response.error("assigning targets failed");
    }
  });
});