package net.koreate.hellking.common.aspect;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class AOPAdvice {
	
	@Around("execution(* net.koreate.hellking.*.controller.*.*(..))")
	public Object checkControllerObject(
			ProceedingJoinPoint pjp
									) throws Throwable{
		log.info("AOP CheckController START");
		
		log.info("target : " + pjp.getTarget());
		
		log.info("method : " + pjp.getSignature().getName());
		
		log.info("args : "+Arrays.toString(pjp.getArgs()));
		
		for(Object o : pjp.getArgs()) {
			System.out.println(o);
		}
		
		Object o = pjp.proceed();
		
		log.info("returns : "+o);
		
		log.info("AOP CheckController END");
		return o;
	}
	
	@Around("execution(* net.koreate.hellking.*.service.*.*(..))")
	public Object checkServiceObject(
			ProceedingJoinPoint pjp
									) throws Throwable{
		log.info("AOP checkServiceObject START");
		
		log.info("target : " + pjp.getTarget());
		
		log.info("method : " + pjp.getSignature().getName());
		
		log.info("args : "+Arrays.toString(pjp.getArgs()));
		
		for(Object o : pjp.getArgs()) {
			System.out.println(o);
		}
		
		Object o = pjp.proceed();
		
		log.info("returns : "+o);
		
		log.info("AOP checkServiceObject END");
		
		return o;
	}
}










