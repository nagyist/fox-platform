/**
 * Copyright (C) 2011, 2012 camunda services GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.camunda.fox.platform.impl.jobexecutor.simple;

import org.activiti.engine.impl.jobexecutor.JobExecutor;

import com.camunda.fox.platform.impl.jobexecutor.spi.JobExecutorFactory;


public class SimpleJobExecutorFactory implements JobExecutorFactory {

  @Override
  public JobExecutor getJobExecutor() {
    return new SimpleJobExecutor();
  }

}
