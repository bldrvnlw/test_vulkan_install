
#include <iostream>
#include <memory>
#include <vector>
#include "testapp_config.h"
#ifdef USE_VULKAN_KOMPUTE  
    #include <kompute/Kompute.hpp>
#endif
#include <shader.hpp>

int
main()
{
  auto A = std::vector<float>{ 2.0, 4.0, 6.0 };
  auto B = std::vector<float>{ 0.0, 1.0, 2.0 };
  auto C = std::vector<float>(3, 0.0);
#ifdef USE_VULKAN_KOMPUTE    
    kp::Manager mgr;

    std::shared_ptr<kp::TensorT<float>> tensorInA =
      mgr.tensor(A);
    std::shared_ptr<kp::TensorT<float>> tensorInB =
      mgr.tensor(B);
    std::shared_ptr<kp::TensorT<float>> tensorOut =
      mgr.tensor(C);

    const std::vector<std::shared_ptr<kp::Tensor>> params = { tensorInA,
                                                              tensorInB,
                                                              tensorOut };

    const std::vector<uint32_t> shader = std::vector<uint32_t>(
      shader::SHADER_COMP_SPV.begin(), shader::SHADER_COMP_SPV.end());
    std::shared_ptr<kp::Algorithm> algo = mgr.algorithm(params, shader);

    mgr.sequence()
      ->record<kp::OpTensorSyncDevice>(params)
      ->record<kp::OpAlgoDispatch>(algo)
      ->record<kp::OpTensorSyncLocal>(params)
      ->eval();

    // prints "Output {  0  4  12  }"
    std::cout << "GPU Vulkan Output: {  ";
    for (const float& elem : tensorOut->vector()) {
        std::cout << elem << "  ";
    }
    std::cout << "}" << std::endl;

    if (tensorOut->vector() != std::vector<float>{ 0, 4, 12 }) {
        throw std::runtime_error("Result does not match");
    }
#else
    std::cout << "Vulkan kompute not enabled" << std::endl;
    for (size_t i = 0; i < A.size(); i++) {
        C[i] = A[i] * B[i];
    }
    std::cout << "CPU Output: {  ";
    for (const float& elem : C) {
        std::cout << elem << "  ";
    }
    std::cout << "}" << std::endl;  
#endif
    return 0;
}