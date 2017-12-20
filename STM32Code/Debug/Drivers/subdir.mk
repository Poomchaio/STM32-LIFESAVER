################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/cs43l22.c \
../Drivers/lis302dl.c \
../Drivers/lis3dsh.c \
../Drivers/stm32f4_discovery.c \
../Drivers/stm32f4_discovery_accelerometer.c \
../Drivers/stm32f4_discovery_audio.c 

OBJS += \
./Drivers/cs43l22.o \
./Drivers/lis302dl.o \
./Drivers/lis3dsh.o \
./Drivers/stm32f4_discovery.o \
./Drivers/stm32f4_discovery_accelerometer.o \
./Drivers/stm32f4_discovery_audio.o 

C_DEPS += \
./Drivers/cs43l22.d \
./Drivers/lis302dl.d \
./Drivers/lis3dsh.d \
./Drivers/stm32f4_discovery.d \
./Drivers/stm32f4_discovery_accelerometer.d \
./Drivers/stm32f4_discovery_audio.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/%.o: ../Drivers/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 '-D__weak=__attribute__((weak))' '-D__packed=__attribute__((__packed__))' -DUSE_HAL_DRIVER -DSTM32F407xx -I"E:/STM32Code/Projecthwsyn/2/Inc" -I"E:/STM32Code/Projecthwsyn/2/Drivers/STM32F4xx_HAL_Driver/Inc" -I"E:/STM32Code/Projecthwsyn/2/Drivers/STM32F4xx_HAL_Driver/Inc/Legacy" -I"E:/STM32Code/Projecthwsyn/2/Drivers/CMSIS/Device/ST/STM32F4xx/Include" -I"E:/STM32Code/Projecthwsyn/2/Drivers/CMSIS/Include" -I"E:/STM32Code/Projecthwsyn/2/Inc"  -Og -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


