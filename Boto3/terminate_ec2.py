import os
import boto3
import logging

DEV_TAGS = os.environ.get("DEV_TAGS")
print("DEV_TAGS", DEV_TAGS)

logger = logging.getLogger()
level = logging.getLevelName(os.environ.get("LOG_LEVEL", "INFO"))
print("Logging level -- ", level)
logger.setLevel(level)

ec2_resource = boto3.resource('ec2')
ec2_client = boto3.client('ec2')
    
def lambda_handler(event, context):

    logger.debug(event)

    print("event -- ", event)

    tags = get_tags(event['tags'] if 'tags' in event else DEV_TAGS)
    print("tags -- ", tags)
    instances = get_instances_by_tags(tags)

    if not instances:
        logger.warning('No instances available with this tags')
    else:
        if event['action'] == 'terminate':
            ec2_client.terminate_instances(InstanceIds=instances)
            logger.info('Terminating instances.')
        else:
            logger.warning('No instances availables with this tags')


def get_tags(tags):
    final_tags = []
    split_tags = tags.split(",")
    for tag in split_tags:
        values = tag.split('=')
        final_tags.append({
            'Name': values[0],
            'Values': [values[1]]
        })
    return final_tags


def get_instances_by_tags(tags):
    response = ec2_resource.instances.filter(Filters=tags)
    print("Response -- ", response)
    for instance in response:
        print("Instance -- ", instance)
    intance_ids = [instance.id for instance in response]
    print("intance_ids -- ", intance_ids)

    return intance_ids