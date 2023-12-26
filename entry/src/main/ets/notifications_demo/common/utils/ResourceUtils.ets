export async function getStringByRes(context: Context, resource: Resource): Promise<string> {
  if (!context) {
    console.log('getStringByRes context is invalid');
    return "";
  }
  if (!resource) {
    console.log('getStringByRes resource is invalid');
    return "";
  }
  let string = await context.resourceManager.getStringValue(resource.id);
  return string;
}